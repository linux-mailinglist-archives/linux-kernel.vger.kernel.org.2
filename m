Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90A34525B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351826AbhKPB4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382428AbhKPBvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 20:51:07 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05FEC0613B9;
        Mon, 15 Nov 2021 15:15:43 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso30149588otg.9;
        Mon, 15 Nov 2021 15:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6eHHZwd5AiaKYcBpg9jtnJaGHGAUHaKvzfg2DTMYK08=;
        b=ObI8n4joXZ8q/dG3SAJwScNI3LORzJPiEx136iyckAl8ktFuJbwAJ60c0UCR6kMGA/
         Vsm6kYOclh5ErheFtU5rKHJotgXci7bE6Z8C+Nnesd18UaDjB7W4mAJpc6bERI7oszLt
         1nI9Kjfs0xG7JFC0LVbJGNjizVp0RJFZwwa0NXVQ4DhwuGChovLPM3zPOT6qmTUsFP3+
         xs8XSwS3IehSoAKKfMUJllsMaYDfEIeicZj5DQR5FJty0kuETD3TPfeEyXFhnoGZL8o5
         hw5uY3UszYWW+l98DaXWXl0PPqbJhNNKvC0iQgjlraZlmZIXnk8KvsX54Hs/ZYiVJ/jx
         Ic0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6eHHZwd5AiaKYcBpg9jtnJaGHGAUHaKvzfg2DTMYK08=;
        b=awl/9QNiV4eXd8xgTdMoUw/wVkmn2z0qXUd5MIPJAYpRQZo2dyP9nR3mhfRKVOZ2RO
         zRqqHJTFDkXtdDAgjSyKsolH/yACLCEdrR2fXPTEq3Tyy3aEmeUTlQH10h6z2wub4JIQ
         RZxaSTGXKHNBZLXR5WQHT5Wh9wPKCtOGkPpvn+oJciBjitjG7beDG5XDixUlC0Uv2gwP
         66/CN0+uhEjOttpUm/dfg5b4rpzz16b6T8dB5keL8G4k+cg0BQoI1CAGpbrBvpU91deQ
         omaRlEWh0wn6JxHpi4YNd+J/376zhgr4Dpu5bWCRuYUFVDnv+m1BMXbPgGAdt3/7dKq6
         OQog==
X-Gm-Message-State: AOAM533eROK+NKtdcO6sOzHJCoMMKC8KDJpW5FnNvNeza/uxgKfDgPUD
        g1TBffcKtBOOCBDXfH2Dc84P8k9K+7U=
X-Google-Smtp-Source: ABdhPJxe6XtS+XxMMBLMZBa9E2wbBtEc8VOSvXHY7qaw1sN58S2DpPDpblFuYZ54DQvOnqqcchLN6Q==
X-Received: by 2002:a05:6830:449e:: with SMTP id r30mr2325653otv.120.1637018142809;
        Mon, 15 Nov 2021 15:15:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s6sm1037028ois.3.2021.11.15.15.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 15:15:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211115210842.11972-1-pauk.denis@gmail.com>
 <CAHp75VcPHi1XyZr=CFbUhiUXK0q-10iBx5U3d==aG8pMG27k1Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v11 0/2] Update ASUS WMI supported boards
Message-ID: <c016d0ca-b8b1-fb06-50f3-06a7b1c4aaea@roeck-us.net>
Date:   Mon, 15 Nov 2021 15:15:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcPHi1XyZr=CFbUhiUXK0q-10iBx5U3d==aG8pMG27k1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 2:01 PM, Andy Shevchenko wrote:
> On Mon, Nov 15, 2021 at 11:09 PM Denis Pauk <pauk.denis@gmail.com> wrote:
>>
>> Add support by WMI interface provided by Asus for B550/X570 boards:
>> * PRIME X570-PRO,
>> * ROG CROSSHAIR VIII HERO
>> * ROG CROSSHAIR VIII DARK HERO
>> * ROG CROSSHAIR VIII FORMULA
>> * ROG STRIX X570-E GAMING
>> * ROG STRIX B550-I GAMING
>> * ROG STRIX B550-E GAMING
>>
>> Add support by WMI interface provided by Asus for X370/X470/
>> B450/X399 boards:
>> * ROG CROSSHAIR VI HERO,
>> * PRIME X399-A,
>> * PRIME X470-PRO,
>> * ROG CROSSHAIR VI EXTREME,
>> * ROG CROSSHAIR VI HERO (WI-FI AC),
>> * ROG CROSSHAIR VII HERO,
>> * ROG CROSSHAIR VII HERO (WI-FI),
>> * ROG STRIX Z390-F GAMING
>> * ROG STRIX B450-E GAMING,
>> * ROG STRIX B450-F GAMING,
>> * ROG STRIX B450-I GAMING,
>> * ROG STRIX X399-E GAMING,
>> * ROG STRIX X470-F GAMING,
>> * ROG STRIX X470-I GAMING,
>> * ROG ZENITH EXTREME,
>> * ROG ZENITH EXTREME ALPHA.
>>
>> I have added "ROG STRIX Z390-F GAMING" to list of supported boards in
>> asus_wmi_sensors.
> 
> Guenter, what is your plan about this patch series? It seems it
> missed, by unknown (?) reason, the v5.16-rc1 (I remember seeing it in
> some of your tree branches at some point).
> 

I don't see it in my record. Earlier I was simply waiting for some
Reviewed-by: tags, which I have never seen. Looking into the commit log,
I do see:

Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Co-developed-by: Eugene Shalygin <eugene.shalygin@gmail.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Did you and Eugene indeed sign this off, ie did you write it, and
Eugene and Denis signed it off ? If so, the tags are in the wrong order.
On the other side, if the code is ultimately from Denis, with your input,
the tags should be either Acked-by: or Reviewed-by: for both Eugene
and yourself.

Note that v11 of this patch series is missing from
https://patchwork.kernel.org/project/linux-hwmon/list/
for some reason.

Guenter
