Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D97C367906
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 06:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhDVE55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 00:57:57 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:39890 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhDVE54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 00:57:56 -0400
Received: by mail-ed1-f46.google.com with SMTP id g17so51162113edm.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 21:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xPuwqXSDNA3qb4GOBBlmEnhsK0h30VSzgWZAMkJobA0=;
        b=YsZnGeh4nAho8ggYU1zasn1NBzPiM5QT5DMYJDEJBgyWDsZXRVasG5WXLH2CNxxNCg
         96Yo2aSzB7F9OSW1xMbejhzWAQutByE1tcVkl26bGlMKXOIk4tDwsSYxvoAawF6DaQ4X
         CO9Tt997+QDZZNMntBYTdSzHl7mAqHVnxyO3AmzB3jWfnknpYcIzgowgv4er+Mym7nEB
         +jQBDfNpkNfa59O7mH3T29OjcDhuKbce7inJKFlun1giLJKHdxOUtKqDrwcEwZcHnOPU
         t/6GwQIy3voVeqJaTp+Afu6jY+/KlDKv535t/+2EPZpQZN64GXlCohsEUel3hgkrSkGi
         Tg+g==
X-Gm-Message-State: AOAM533NpfeTfH836Ga4uEGmdpMa1/AXXsFDHpG/VSH4GBfEQiKZ5xXB
        l4WtssyPRT60mtQUZ+D1LII=
X-Google-Smtp-Source: ABdhPJzgelzMc82d9XqmbzlhHGhvvh7PeOecafTguk8YjmLSzkWXNAWx+duTcFDC9Trw3SGNtO4HgQ==
X-Received: by 2002:a05:6402:514a:: with SMTP id n10mr1501199edd.25.1619067441675;
        Wed, 21 Apr 2021 21:57:21 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id 16sm1047249ejw.0.2021.04.21.21.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 21:57:20 -0700 (PDT)
Subject: Re: [PATCH 106/190] Revert "tty: ipwireless: fix missing checks for
 ioremap"
To:     dsterba@suse.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        David Sterba <dsterba@suse.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-107-gregkh@linuxfoundation.org>
 <20210421155900.GB7604@twin.jikos.cz>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <dd0698e1-9b31-53fc-4dd1-da474cd483bd@kernel.org>
Date:   Thu, 22 Apr 2021 06:57:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421155900.GB7604@twin.jikos.cz>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 04. 21, 17:59, David Sterba wrote:
> On Wed, Apr 21, 2021 at 02:59:41PM +0200, Greg Kroah-Hartman wrote:
>> This reverts commit 1bbb1c318cd8a3a39e8c3e2e83d5e90542d6c3e3.
>>
>> Commits from @umn.edu addresses have been found to be submitted in "bad
>> faith" to try to test the kernel community's ability to review "known
>> malicious" changes.  The result of these submissions can be found in a
>> paper published at the 42nd IEEE Symposium on Security and Privacy
>> entitled, "Open Source Insecurity: Stealthily Introducing
>> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
>> of Minnesota) and Kangjie Lu (University of Minnesota).
>>
>> Because of this, all submissions from this group must be reverted from
>> the kernel tree and will need to be re-reviewed again to determine if
>> they actually are a valid fix.  Until that work is complete, remove this
>> change to ensure that no problems are being introduced into the
>> codebase.
> 
> I've reviewed the patch at the time and now again with fresh eyes, but
> it's IMO a valid fix that would have to be done the same way after
> revert.

ACK -- the same opinion here.

-- 
js
suse labs
