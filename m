Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B810832F40D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhCETjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCETi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:38:57 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC95C06175F;
        Fri,  5 Mar 2021 11:38:57 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id x29so2055020pgk.6;
        Fri, 05 Mar 2021 11:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qAJgbNw9KBqNioDnptWCHAlDfIWtd5u8+ZRDe39se/w=;
        b=BoJ5pB1gsmBYyhYj6uXrjMiM/HZVJKlQ3H2cdr7ls3HPILovWa4gmUYX5CHtDqqpzz
         JO9Px+5oacSMkKj1TBCvgRttIvpKSLHD3PIYNFU8rJZWm2jp6lZkp2jt1BA5dLjuqgsA
         MUrtdTuVjvfbU1SDZZW8xOHrBqoBIAj15P24+3f+MkIvYKnPPQ2S06rBOZTNpqLwXLHF
         iuykssBPu0zMvBNJwTAHrNUsmfOX+kBWdmYAU5JTm/Gx/T6cWNL30hOjlm8l981vOvww
         FosprjLZ1CJYjMUtfyYnw+46PZkBK8XSl5Z43ho5WESW26llmU5NtfUEstASOPofayA8
         gxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qAJgbNw9KBqNioDnptWCHAlDfIWtd5u8+ZRDe39se/w=;
        b=HJFzupb2Any2z9dSGAcZh4Me04q28RKASHLVvAswzHEtcCdzaNydEYbJQKVIuRl6Zd
         fcvdsFBC0wv8MzxkhcXCGKEPNIXddsFaoc2bl7Srwdj3rlbJdftkUo9OlEzQ4VnwIAG6
         pEEk0y8HHb7YFg1T7sMm75NvEYl+Dv/d9V0vbRxXwSgz8uKm+2r9APWM7dY6AE+bYkYh
         W/HtYKMtW1EfrHgJDJsV2KHaHIAbqclKDu8E6aR8supFTrsCxCpedRWFqzB4Yz0JfEyU
         h2cU16AxPad+hUoMfLanvfQmyFs/bm+PhrjPa/62CXtjNN3HtBEhlE+WvD6OwUHAgfb2
         rn1g==
X-Gm-Message-State: AOAM5305yZ0JeBGI0KhNktP/q/3/fw+zIJbVS3J1rRyU1APRziBtAs81
        VQAB8xR6rhkqiba/7Pgx1VU=
X-Google-Smtp-Source: ABdhPJyxrxQRE8Hql05EoHrzeYX0bTCaIz+xT1bVtCRehDR1Cbi5fj5I7E+a27xt0AB8zVohEhteBA==
X-Received: by 2002:a05:6a00:1a01:b029:1da:a7ee:438f with SMTP id g1-20020a056a001a01b02901daa7ee438fmr10643151pfv.77.1614973137167;
        Fri, 05 Mar 2021 11:38:57 -0800 (PST)
Received: from ?IPv6:2405:201:600d:a089:58af:ffb4:5a90:f2bc? ([2405:201:600d:a089:58af:ffb4:5a90:f2bc])
        by smtp.gmail.com with ESMTPSA id i22sm3108234pjz.56.2021.03.05.11.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 11:38:56 -0800 (PST)
Subject: Re: [RFC] scripts: kernel-doc: fix attribute capture in function
 parsing
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210305182000.8363-1-yashsri421@gmail.com>
 <20210305184322.GN2723601@casper.infradead.org>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <bcd38964-bfff-99c2-eb24-1942836e9526@gmail.com>
Date:   Sat, 6 Mar 2021 01:08:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210305184322.GN2723601@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 12:13 am, Matthew Wilcox wrote:
> On Fri, Mar 05, 2021 at 11:50:00PM +0530, Aditya Srivastava wrote:
>> Provide a simple fix by adding "__attribute_const__" in the corresponding
>> regex expression.
>>
>> A quick evaluation by running 'kernel-doc -none' on kernel-tree reveals
>> that no additional warning or error has been added or removed by the fix.
> 
> I'm no perlmonger, but why isn't this simply:
> 
> +++ b/scripts/kernel-doc
> @@ -1753,6 +1753,7 @@ sub dump_function($$) {
>      $prototype =~ s/^__inline +//;
>      $prototype =~ s/^__always_inline +//;
>      $prototype =~ s/^noinline +//;
> +    $prototype =~ s/__attribute_const__ +//;
>      $prototype =~ s/__init +//;
>      $prototype =~ s/__init_or_module +//;
>      $prototype =~ s/__meminit +//;
> 
> (completely untested)
> 
>> +++ b/scripts/kernel-doc
>> @@ -1753,6 +1753,7 @@ sub dump_function($$) {
>>      my $prototype = shift;
>>      my $file = shift;
>>      my $noret = 0;
>> +    my $attribute_const = qr{__attribute_const__};
>>  
>>      print_lineno($new_start_line);
>>  
>> @@ -1808,7 +1809,7 @@ sub dump_function($$) {
>>  	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>>  	$prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>>  	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>> -	$prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>> +	$prototype =~ m/^(\w+\s+\w+\s*\*+$attribute_const?)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>>  	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>>  	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
>>  	$prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||

Hi Matthew
You are correct, it should be placed there. I was considering it as a
return type instead.
I'll send a modified v2 with the changes.

Thanks
Aditya
