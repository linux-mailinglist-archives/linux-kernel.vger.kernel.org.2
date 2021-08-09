Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFA33E4C29
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhHISbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:31:48 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:38463 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhHISbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:31:47 -0400
Received: by mail-pl1-f182.google.com with SMTP id a5so1742020plh.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 11:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bFb1IhpFXcCyoGH7wkyqlLUnYGPS4z0tSfbGyOXHUPE=;
        b=FfHEHoe8eNnYmmN5l6IaKt5YKYERb7K7n814CtlTmBTtK/rCBRJ1SQgpZqgiYDFDFx
         t2vQkLQgyBQYj/+W3bo7HhdapqYk76xx+o15EI3LzaW1I0uu5i4ekWWPnNyUodMqFhVe
         3W8h1oQvZXg8fuF9xfAj/N0bAKjIZVkRf/LjNts56JeQO4ryGA2fV+xntUpnFw5Gq2WM
         qI+tbF7fUdiYIoNR0U0/hWKJZAaDHfVQIdcSvl8K+ZuMm0XWcW4MyKlTGAwYmzCYDpD9
         TS4W4X8wbqerNPblDuWmUVDlJUntv/fdtMc7AH8EZf/Wv0R6i7zTYMg1ppZFSceU0Byv
         Th+w==
X-Gm-Message-State: AOAM530omjzvUO0HOezRY/LVTQ5TOqtJiYNYnPIGndJOnRzIRzkuOnsF
        798pBZPIEctKILMLgm12i+c=
X-Google-Smtp-Source: ABdhPJwYJzqSG9vIWyEOyMxZ+KrsjviDk8lrQZfxNYe78e1DVNlCYb5qEwEUNr9UgP84UI7W0xNybA==
X-Received: by 2002:a17:90a:7185:: with SMTP id i5mr26809652pjk.236.1628533886265;
        Mon, 09 Aug 2021 11:31:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7dd4:e46e:368b:7454? ([2601:647:4000:d7:7dd4:e46e:368b:7454])
        by smtp.gmail.com with ESMTPSA id t13sm18004085pjg.25.2021.08.09.11.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 11:31:25 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] configfs: Add unit tests
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Yanko Kaneti <yaneti@declera.com>
References: <20210805043503.20252-1-bvanassche@acm.org>
 <20210805043503.20252-4-bvanassche@acm.org> <20210809145953.GB21234@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bcf5fd83-b30a-8887-361e-603821562d9a@acm.org>
Date:   Mon, 9 Aug 2021 11:31:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809145953.GB21234@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 7:59 AM, Christoph Hellwig wrote:
>> text and binary attribute support. This is how I run these tests:
>>
>> set -e
>> if [ -e .config ]; then
>>     make ARCH=um mrproper
>> fi
>> if [ ! -e .kunit/.kunitconfig ]; then
>>     cat <<EOF >.kunit/.kunitconfig
>> CONFIG_CONFIGFS_FS=y
>> CONFIG_CONFIGFS_KUNIT_TEST=y
>> CONFIG_KUNIT=y
>> CONFIG_PROVE_LOCKING=y
>> CONFIG_SYSFS=y
>> CONFIG_UBSAN=y
>> EOF
>>     cp .kunit/.kunitconfig .kunit/.config
>> fi
>> ./tools/testing/kunit/kunit.py run
> 
> This is very useful documentation, but shouldn't it go into a README.kunit
> or similar instead of a commit message?

I can store this documentation in a new README, but isn't this something
that has already been explained in
Documentation/dev-tools/kunit/kunit-tool.rst?

>> +config CONFIGFS_KUNIT_TEST
>> +	bool "Configfs Kunit test" if !KUNIT_ALL_TESTS
>> +	depends on CONFIGFS_FS && KUNIT=y
>> +	default KUNIT_ALL_TESTS
> 
> Why does it depend on KUNIT=y?  What is the issue with a modular KUNIT
> build?

The unit tests calls do_mount(). do_mount() has not been exported and
hence is not available to kernel modules. Hence the exclusion of KUNIT=m.

>> +static int mkdir(const char *name, umode_t mode)
>> +{
>> +	struct dentry *dentry;
>> +	struct path path;
>> +	int err;
>> +
>> +	err = get_file_mode(name);
>> +	if (err >= 0 && S_ISDIR(err))
>> +		return 0;
>> +
>> +	dentry = kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTORY);
>> +	if (IS_ERR(dentry))
>> +		return PTR_ERR(dentry);
>> +
>> +	err = vfs_mkdir(&init_user_ns, d_inode(path.dentry), dentry, mode);
>> +	done_path_create(&path, dentry);
> 
> To me this sounds like userspace would be a better place for these
> kinds of tests.

Splitting the code that can only be run from inside the kernel (creation
of configfs attributes) and the code that can be run from user space and
making sure that the two run in a coordinated fashion would involve a
significant amount of work. I prefer to keep the current approach.

Thanks,

Bart.


