Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8913FF3F4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 21:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347310AbhIBTQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbhIBTQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:16:12 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D163C061575;
        Thu,  2 Sep 2021 12:15:14 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 107-20020a9d0bf4000000b0051b8be1192fso3867382oth.7;
        Thu, 02 Sep 2021 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2PHzwL7w/TXZhLdMTKwznQCN6/znjMeKZ/ixaiuLA0E=;
        b=eT4hcfknQSnLb8CAelm9EJ3gz+TQxqLhE2fLG4nSGcLrIwfhq7cyL5X3wZpBAeTfwG
         ur11NYfygInfw7+BaKOx7lPATgv//Dkcz/ksQrcGYW5K6R2ViFSY4K0Aqk5z0rGNh8Xk
         fADQQZn218LmudEWvlzztzp4KCEz00hmTfAgPfeIzmYQyZwmcgFmtHeJSiiF+tH++hlt
         4BqsCV5b+VXw7RdPyZM9UQhcfXHgL8cq3YpqnkJIJx6q14+2kAV5GkuQDk7DXU83gv4I
         z3VO5HsSo9JT59zELAZZJH2I2q4PSQ+ldaBqFc9Xg+nCUFb+Xfb5CKLE9oPmx/LiCsWy
         Kb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2PHzwL7w/TXZhLdMTKwznQCN6/znjMeKZ/ixaiuLA0E=;
        b=PBvDlHfpGo6/c5y2XmKeOadsDsJxJUdey+fLa/Gd01RGGk/KMTugfSzN9A33EGxegB
         eqUuGXOyxNWcHRH86QNKytHnTr4cz4WcVpkVd8cl5OVOVnnLerL54dMshxtBsl7imIc9
         LubHWxUjWPnOPUhOM9yYDWiBBEd/1eNxMxk64O7aCZ/XNeCW6VrkVL1pYbmw+N/4nRJB
         aWkbSxPlH/8wpYNjwvRDcU9paL2PCRD/9F5sivomzaAryUcA/rtttqWpLNRhz6bNLGJ8
         jNf4AO0AaN3FKvjyy4jLgV/X3RT8k+Pb9/Qsk7entd6mUbmjcfBKD6bcMdoUb3ubYsyD
         ErGA==
X-Gm-Message-State: AOAM5301lCFUC0QPGR7slDdWRRnAVAo4kRVRejH8uje46bUHdk7qp3uf
        TUZJU6uMFrBm0Wl0ucdODXs=
X-Google-Smtp-Source: ABdhPJzpR9WvJsa+I/KVFDvkAyxQ7094Jo5q4faWfdaBZ8/Ckft9vvWAblaml/ktcISq31+mGdI9xA==
X-Received: by 2002:a9d:309:: with SMTP id 9mr4070215otv.365.1630610113546;
        Thu, 02 Sep 2021 12:15:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k1sm511866otr.43.2021.09.02.12.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 12:15:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 2 Sep 2021 12:15:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, yazen.ghannam@amd.com,
        mingo@redhat.com, nathan.fontenot@amd.com, lewis.carroll@amd.com,
        suma hegde <suma.hegde@amd.com>
Subject: Re: [PATCH 2/3] k10temp: Remove residues of current and voltage
Message-ID: <20210902191511.GA1754521@roeck-us.net>
References: <20210902174155.7365-1-nchatrad@amd.com>
 <20210902174155.7365-2-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902174155.7365-2-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 11:11:54PM +0530, Naveen Krishna Chatradhi wrote:
> From: suma hegde <suma.hegde@amd.com>
> 
> Commit id "b00647c46c9d7f6ee1ff6aaf335906101755e614",
> adds reporting current and voltage to k10temp.c
> 
> The commit id "0a4e668b5d52eed8026f5d717196b02b55fb2dc6",
> removed reporting current and voltage from k10temp.c
> 
> The curr and in(voltage) entries are not removed from
> "k10temp_info" structure. Removing those residue entries.
> while at it, update k10temp driver documentation
> 
> Signed-off-by: suma hegde <suma.hegde@amd.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

Applied.

> ---
> This is an unrelated change, should we submit this seperately or drop this for now?
> 
Guess the above answers your question.

Thanks,
Guenter

>  Documentation/hwmon/k10temp.rst | 17 -----------------
>  drivers/hwmon/k10temp.c         |  6 ------
>  2 files changed, 23 deletions(-)
> 
> diff --git a/Documentation/hwmon/k10temp.rst b/Documentation/hwmon/k10temp.rst
> index 8557e26281c3..91b99adc6c48 100644
> --- a/Documentation/hwmon/k10temp.rst
> +++ b/Documentation/hwmon/k10temp.rst
> @@ -132,20 +132,3 @@ On Family 17h and Family 18h CPUs, additional temperature sensors may report
>  Core Complex Die (CCD) temperatures. Up to 8 such temperatures are reported
>  as temp{3..10}_input, labeled Tccd{1..8}. Actual support depends on the CPU
>  variant.
> -
> -Various Family 17h and 18h CPUs report voltage and current telemetry
> -information. The following attributes may be reported.
> -
> -Attribute	Label	Description
> -===============	=======	================
> -in0_input	Vcore	Core voltage
> -in1_input	Vsoc	SoC voltage
> -curr1_input	Icore	Core current
> -curr2_input	Isoc	SoC current
> -===============	=======	================
> -
> -Current values are raw (unscaled) as reported by the CPU. Core current is
> -reported as multiples of 1A / LSB. SoC is reported as multiples of 0.25A
> -/ LSB. The real current is board specific. Reported currents should be seen
> -as rough guidance, and should be scaled using sensors3.conf as appropriate
> -for a given board.
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 38bc35ac8135..3618a924e78e 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -362,12 +362,6 @@ static const struct hwmon_channel_info *k10temp_info[] = {
>  			   HWMON_T_INPUT | HWMON_T_LABEL,
>  			   HWMON_T_INPUT | HWMON_T_LABEL,
>  			   HWMON_T_INPUT | HWMON_T_LABEL),
> -	HWMON_CHANNEL_INFO(in,
> -			   HWMON_I_INPUT | HWMON_I_LABEL,
> -			   HWMON_I_INPUT | HWMON_I_LABEL),
> -	HWMON_CHANNEL_INFO(curr,
> -			   HWMON_C_INPUT | HWMON_C_LABEL,
> -			   HWMON_C_INPUT | HWMON_C_LABEL),
>  	NULL
>  };
>  
