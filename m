Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0198B3976DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhFAPks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhFAPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:40:48 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F525C061574;
        Tue,  1 Jun 2021 08:39:05 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id ee9so7405731qvb.8;
        Tue, 01 Jun 2021 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=iY7omL5QvGPktjhcbH3ePgrdipmWmknzPOenKs7LO/8=;
        b=NFnKs88jGMZA5eIcHvWUf7dq5SBW3reOr//0aUOt0xiYg+THG11fK0I2rQ6ayc3Hae
         9lFzgdSgKAezYTKehR/9/rH+igKi0a+XeuEbzEyl+8Koj8GaspMFVsk+MrPkM8OxZ1ft
         MwdRJKFK37QiUDCL8HQBe5eiKBorIN6ANee6mXeQhIvdsz/1Vc2+4b6eYdnenJE/xgsL
         YUPi0YQjEtlCjmETljZ400y2FJgPgwiOi+XV0VbMAsavtoQGWmryY2kvoH/p+8pAN42t
         h++whHQW80RYebwXMx4KmbdK7iQL/PJeV6OCJqlzE4kb9TPq83OzwclqHt0VyXvMqLtI
         wxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iY7omL5QvGPktjhcbH3ePgrdipmWmknzPOenKs7LO/8=;
        b=U3si/rSRRi8M2eIiUTjleO6NQN7DmZ+x4JHEQU6GaSXEQbQwPNzphk5EZrbwYFqGXW
         DmDAkSUemW99DjwOcCO2YKiqoTFnxqMUTS2k18EY7+9KoPPSSAHE5hxE9g+MuCgxucHU
         4wfnmD6kTb0ZzGPMdekrT53c6Wq4ANPv2EeT5+P8uCVLPGHb0Zoa5LyqC2x0xSgYGnPH
         15i1T7IJ5XCR8d2NW8ZSL4rOMfeSMvWLmGuIhUAbwi/vUIeon9DwjFYC2PRzQjYdjsL+
         maZChtJueivs3XnkRNObmnjfFDHMgF09C7atemoYsLCYLg4RHN64HzehAj1DNdkAPDg9
         jh1Q==
X-Gm-Message-State: AOAM531MuPrZFfbuFWioG/awInDrVIQCOmMTzXF/cmMnIOMMsiY3sStJ
        LAM7RiFup/LzVlho6KMrapJS2gTE03s=
X-Google-Smtp-Source: ABdhPJwGeJc1CW8EQ/rUJUAQu0ButFl9twM19BYRdMCB4CeFdg/T2F22UaFK5j3t2M+eaWXK4p1x1A==
X-Received: by 2002:a0c:f7cb:: with SMTP id f11mr23080709qvo.34.1622561944603;
        Tue, 01 Jun 2021 08:39:04 -0700 (PDT)
Received: from ?IPv6:2804:14c:125:811b:fbbc:3360:40c4:fb64? ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.gmail.com with ESMTPSA id e4sm10537671qtq.5.2021.06.01.08.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 08:39:04 -0700 (PDT)
Subject: Re: docs: Convert the Speakup guide to rst
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <20210531220754.h4ep2dj65wl6hejf@begin>
From:   Igor Torrente <igormtorrente@gmail.com>
Message-ID: <b8769ad4-9188-a735-3ac4-4a79b9b06487@gmail.com>
Date:   Tue, 1 Jun 2021 12:39:01 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210531220754.h4ep2dj65wl6hejf@begin>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On 5/31/21 7:07 PM, Samuel Thibault wrote:
> Hello,
> 
> Adding the speakup list in the loop.
> 
> Igor Matheus Andrade Torrente wrote:
>> Modify some parts of the text and add the necessary formatting to leverage
>> the rst features. Including links, code-blocks, bullet lists, etc.
>>
>> Also, adds a table of contents at the beginning and a section to the
>> license.
>>
>> This change helps integrate this documentation to the rest of the rst
>> documentation.
> 
> Mmm, I'm unsure how the result is readable with the speakup screen
> reader itself. I have attached the result, could people on the speakup
> mailing list check how well it goes? If it significantly degrades
> readability, we'll have to reject the move to rst formatting, since in
> the end it's people who use the speakup screen reader who need to be
> able to read this document.

I was reading all the emails sent in this thread, but I'm not sure how I 
should proceed. Do think should I continue to improve the patch with the 
Jani Nikula suggestions? Or abandon it? Or keep both versions?

> 
> Samuel
> 

Thanks,
---
Igor M. A. Torrente
