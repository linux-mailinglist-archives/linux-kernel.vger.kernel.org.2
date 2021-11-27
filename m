Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79C145FC16
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 03:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhK0Cb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 21:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhK0C36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 21:29:58 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC3EC08ED4B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:33:25 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id u17so7697852plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 17:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding:content-disposition;
        bh=X8QlSj+7J7KTHGL3d4vBencwUADDVpyBriTFH4PukKs=;
        b=mSJ8fJrFPmmxdffytRC+GUJ3cqSCF0AxMspew4IGovmY1kkJQAEcOEZ6OQkPpbM3OK
         RxjOcE7SBAFsjjrEPgXP5L7JnOX5BEUhlgdxBIU7/rFJwC+0NQbjaaOmfEBNMWhTti+F
         oHnJgVL+V2ys1uS4xKLuN+/55kjhuNqCDmbJdk8WPpYswsbjozEGTzJMWSot44WPqwAr
         YzJldmEdzQ39MQLg3nDGC5OktC2S/UPjnn9bK93X7PNusl59FfK9FzEbhPcrHasKdHne
         MZAb0m8z6LgHZr/UILj8VzkN2t4mTlzyPO/SpJOGAiMrcctBGBsCEZRuDxUBIA3zxT/Q
         KUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding
         :content-disposition;
        bh=X8QlSj+7J7KTHGL3d4vBencwUADDVpyBriTFH4PukKs=;
        b=yXpwxXc7VoNfWgybiolUOupt86+7fOvkYFOC/NWTjalSJ05ToJteFXXvK4t20kQfiM
         hrQra3X11udLH5UfmdqzEvP08mPCdKCV3Zjyh4WOIg+zo/HH5f8urLarHPhLjHu++hu6
         rrhWxrelBA74DOig3106Kfv5cobh16Pki9Qec0RqCl/4W17VQqbjHpojq871OOrjS/II
         uyfieMvao6IVvdyZx33njM1lMbf2mMhROcwjhCvkbZgc7NY+0WKveaO3/Lll8M9DHO9Z
         UOrVvavJdHF2Je7nTfEQmQ3TvSFOH5GpbNaF1v8cu8GwlDsn2h2wWXmdzT4XgLRfpVcz
         jMvg==
X-Gm-Message-State: AOAM530jWSVblPfr95qaZVd6dmlkhUMGjF4ysZdt0Vs19+BU51YgP+5d
        Y96sC4E29b/qo8e5N6GC2K8=
X-Google-Smtp-Source: ABdhPJzI+eUkvspJeekb6OOEDPmnxyF8L1bDDVL+PQz2etsOx1uABAB180rQOM/viSL3PN6icMqwSg==
X-Received: by 2002:a17:90a:c78f:: with SMTP id gn15mr19678485pjb.54.1637976805227;
        Fri, 26 Nov 2021 17:33:25 -0800 (PST)
Received: from pc ([223.197.3.99])
        by smtp.gmail.com with ESMTPSA id z22sm9007173pfe.93.2021.11.26.17.33.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Nov 2021 17:33:24 -0800 (PST)
Date:   Sat, 27 Nov 2021 09:33:19 +0800
From:   Zackary Liu <zackary.liu.pro@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "=?utf-8?Q?masahiroy=40kernel.org?=" <masahiroy@kernel.org>,
        "=?utf-8?Q?ripxorip=40gmail.com?=" <ripxorip@gmail.com>,
        "=?utf-8?Q?mpe=40ellerman.id.au?=" <mpe@ellerman.id.au>,
        "=?utf-8?Q?linux-kernel=40vger.kernel.org?=" 
        <linux-kernel@vger.kernel.org>
Message-ID: <A5940078-2624-4F28-859A-9F11C1F5058A@getmailspring.com>
In-Reply-To: <YaEECIyT3LT7JQzQ@kroah.com>
References: <YaEECIyT3LT7JQzQ@kroah.com>
Subject: Re: [PATCH] scripts/tags: merge "TAGS" and "tags" in case
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 26 2021, at 11:58 pm, Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Nov 03, 2021 at 11:35:29PM +0800, Zhaoyu Liu wrote:
>> merge "TAGS" and "tags" for the code more concise
>> 
>> Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
>> ---
>>  scripts/tags.sh | 14 +++++---------
>>  1 file changed, 5 insertions(+), 9 deletions(-)
>> 
>> diff --git a/scripts/tags.sh b/scripts/tags.sh
>> index 16d475b3e203..a9181dd0fee2 100755
>> --- a/scripts/tags.sh
>> +++ b/scripts/tags.sh
>> @@ -315,15 +315,11 @@ case "$1" in
>>  		dogtags
>>  		;;
>>  
>> -	"tags")
>> -		rm -f tags
>> -		xtags ctags
>> -		remove_structs=y
>> -		;;
>> -
>> -	"TAGS")
>> -		rm -f TAGS
>> -		xtags etags
>> +	"TAGS" | "tags")
>> +		rm -f $1
>> +		xtags $([ $1 = "tags" ]	\
>> +			&& echo ctags		\
>> +			|| echo etags)
>>  		remove_structs=y
>>  		;;
> 
> Ick, that's much harder to read and understand.
> 
> What is wrong with the existing code?  It's obvious and makes sense, it
> is not duplicating any lines here except the one "remove_structs=y"
> which is fine.
> 
> I'm not going to take this, sorry.
> 
> greg k-h
> 

Ok you're right, Easy to understand is better.
Thank you.

zackary
