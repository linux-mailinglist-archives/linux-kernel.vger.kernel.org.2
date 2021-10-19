Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E9E432CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 06:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhJSE60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 00:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSE6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 00:58:25 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6214C06161C;
        Mon, 18 Oct 2021 21:56:12 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id o4so3039876oia.10;
        Mon, 18 Oct 2021 21:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bpS2GG3XN2CaoLrol9u8Yu+pu0zzW3Q/ybUX9NDPVZk=;
        b=hVbF97jHZ3FxInU19HaYpREimJVEOr+fIUwN06EZveevoFHDkuXiBUi3Hx8LCJy2RR
         KfL0aQ3bHVXMV8y9wc6zVTUMRpDoKooDWsPctkSP/ZjxBFjX2kIhPqdHCX9t7MC43kj5
         GI90lY1OeqBPkzMeFJxRWccHZksCGWJJS5nKo0uQWV4S3JxmXFAeRK1tVxLRIegVlgB5
         Ke9cpGI41k76UfTvvp2F4u6CymDn+4rUav4xvPm5Bg0SOR42y/yO0g9XytY/kFENCL4Y
         DXPUIIGOXLvzeTTRYU+mjpqb47SEhA/O2j6BWwl0pMtMfvsx1lUglWQoTKc/jE0SJHz3
         7jwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bpS2GG3XN2CaoLrol9u8Yu+pu0zzW3Q/ybUX9NDPVZk=;
        b=JRrUbiSju0lmMzPaPs+ed17FmwoRbmyL4DxbzpT2EuiDRc8DkoN7COv/VOdhx1WWNy
         LqPBYgviMGay+KDNO0S/GBuEMy1wSJYkQhyPNOtTSTeessFI8uZHuOvWyyindszf4U/E
         TYgEjv7236k9QLQIcFbgI0K+TuDH4dIVsh43XN7P+t1ryYmWyPIBp+UWjpdfQuBmPrBL
         RoV3tJtqiF37WRhhEZlbt3KrfFHah7Z+k1jnUUwZGwgyPKfyeIDTls0LbV5u/MJePWpV
         QqTTOMHbPh+DT0SFmepUl4n2E9DuOzIl1vm2eylXPUtb2wJH38gMS6yXN7OqQVP+E3mN
         WTBA==
X-Gm-Message-State: AOAM531mNUizuoyyipNRa08WCkuslb1ez0tojMYsCSEASaWXF+hLN2SC
        hUOEaupK6Bb0aipKsb0zOsBx7pdprzk=
X-Google-Smtp-Source: ABdhPJznYOgSWRzG3kc+CLiahyzHIAiMVPVLbjddNrfbyX7niJGEMGMItFVh8CzanjcB5dgGn8UTgQ==
X-Received: by 2002:aca:ba41:: with SMTP id k62mr2468755oif.53.1634619371818;
        Mon, 18 Oct 2021 21:56:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y4sm3385807oix.23.2021.10.18.21.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 21:56:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: Potential issue with smb word operations for tmp461 device in
 tmp401 driver
To:     "Wilson, David T. (GSFC-5870)" <david.wilson@nasa.gov>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
References: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7f334e4c-0e71-2005-854f-c2d4e068ef85@roeck-us.net>
Date:   Mon, 18 Oct 2021 21:56:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On 10/15/21 10:43 AM, Wilson, David T. (GSFC-5870) wrote:
> Hi,
> 
> I am reporting what I believe is a potential issue in the tmp401 driver for the tmp461 device specifically. I am new to reporting issues, so I apologize in advance if I've provided insufficient information for an issue report.
> 
> The problem I'm encountering is that when I use the tmp401 linux driver to read temperature values from the tmp461, all of the read temperature values end with 996 (e.g. 33996, 38996, etc...).
> 
> Looking further into the tmp401 commit messages, I see that the driver was changed to use smb word operations instead of separate byte operations. Although the other supported devices (i.e. tmp432, etc...) are noted to support 16-bit read operations in their respective datasheets, I see no indications of 16-bit read support in the tmp461 datasheet, which is supported by my inquiry in the TI forums (https://e2e.ti.com/support/sensors-group/sensors/f/sensors-forum/1044935/tmp461-linux-driver-support-and-16-bit-temperature-register-reads).
> 
> Reverting the driver to the commit before the smb word change, I am then able to read temperature values that do not end only with 996. As a result, I believe that the tmp461 support may be partially broken by the switch to smb word operations.
> 

can you try to instantiate the lm90 driver (instead of the tmp401 driver)
and let me know if it works for you ? If your system uses devicetree,
you might have to select "ti,tmp451" instead of "ti,tmp461".

Thanks,
Guenter
