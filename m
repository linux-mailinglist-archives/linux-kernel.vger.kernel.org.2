Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8233E88BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 05:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhHKDN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 23:13:59 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:39670 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhHKDN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 23:13:57 -0400
Received: by mail-pj1-f44.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so7395021pjn.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 20:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PPgnnFQnDyvLSvdk61y23ETmSlhBYVAGUD4y9vVkgQ4=;
        b=CAf5P+tqnI0SNZ8l77EvZIcKNYqbsgNas4sXr9GdkoXd+WuppY2whVJuZThneBlDE2
         TU/Dt3MOD7DnfGc6G3O9BMh58KhgS7NTTVu/zPTQ/wxwGg7kwbP333f/UaM3l040sg8f
         SlrnlgzyKPgh2NHkOUIoLeBrGXk9aMNkRj9GRWsR74bypVpMDD37uQqldSTt7BcsgEPD
         XlD05EJtibWKNot90UojkdMFtsh0fKO+7xObjb4ajqPpjl2QG4Z+JSgDnEPyCp5xL8UU
         NipUYNMaY//yF7g+VI7EPWmXhVEO1+lFkZYsDq8HLybK+sh8yKVUdTRoopX7doK21A5W
         mdNw==
X-Gm-Message-State: AOAM5338YuWwIelTanjIOjx4G/V3LpT8C8inJpIxhaXt8xLliQEmqbD6
        lLx9FC9e5K5bI72VxbeYCIQ=
X-Google-Smtp-Source: ABdhPJxFbY23P72cJAIj80HfRyKTrmNg7udkm68SEFkMyz8yR+4UfqiqaQPq6OjXd702QkePKnIxig==
X-Received: by 2002:a17:902:da8a:b029:12c:4261:a2d6 with SMTP id j10-20020a170902da8ab029012c4261a2d6mr4576500plx.50.1628651614412;
        Tue, 10 Aug 2021 20:13:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:2e5f:88b1:dfed:ae53? ([2601:647:4000:d7:2e5f:88b1:dfed:ae53])
        by smtp.gmail.com with ESMTPSA id q1sm26428550pfn.6.2021.08.10.20.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 20:13:33 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] configfs: Add unit tests
To:     Brendan Higgins <brendanhiggins@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>
References: <20210805043503.20252-1-bvanassche@acm.org>
 <20210805043503.20252-4-bvanassche@acm.org> <20210809145953.GB21234@lst.de>
 <CAFd5g46D2KNmsH2qyt_HdWN3peT=HM+We2cgGV5SUzjL2jgSiA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a1b7071f-57f6-c5e2-0c2f-2ac3414d1c76@acm.org>
Date:   Tue, 10 Aug 2021 20:13:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g46D2KNmsH2qyt_HdWN3peT=HM+We2cgGV5SUzjL2jgSiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 3:00 PM, Brendan Higgins wrote:
> On Mon, Aug 9, 2021 at 7:59 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>>> text and binary attribute support. This is how I run these tests:
>>>
>>> set -e
>>> if [ -e .config ]; then
>>>     make ARCH=um mrproper
>>> fi
>>> if [ ! -e .kunit/.kunitconfig ]; then
>>>     cat <<EOF >.kunit/.kunitconfig
>>> CONFIG_CONFIGFS_FS=y
>>> CONFIG_CONFIGFS_KUNIT_TEST=y
>>> CONFIG_KUNIT=y
>>> CONFIG_PROVE_LOCKING=y
>>> CONFIG_SYSFS=y
>>> CONFIG_UBSAN=y
>>> EOF
>>>     cp .kunit/.kunitconfig .kunit/.config
>>> fi
>>> ./tools/testing/kunit/kunit.py run
>>
>> This is very useful documentation, but shouldn't it go into a README.kunit
>> or similar instead of a commit message?
> 
> You could also put this in a .kunitconfig specific to your subsystem
> like we did for ext4:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/ext4/.kunitconfig
> 
> You can then build using this .kunitconfig with something like:
> 
> ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig

Will look into this. Thanks for the feedback!

Bart.
