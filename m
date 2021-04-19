Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B75363E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhDSJIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhDSJIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:08:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99EBC061760
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:07:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l4so51700286ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pYmNdn17WaFVbSZzxAjZrcjydk4+7qcEdKI8uYhDoCc=;
        b=jVuU6ug35OHQRuITgQo7roH/PJ5d7X2QWW/1tW3exjd8G59oaFd25xfRl7FI4lB/Pb
         9ZagEmSyW4WxtgIJLOzv8g9MDdvPMaSCkDgZJGMlMQZ96kJKPrD6KXKqyTbHvuQ++3y8
         BgaYjVGdHRP2bmn0KIfIXBDU80JqfSX9x6rGzS/9D+sxOyanEzfrzwCh7aOuDBUHnlsJ
         MnaljzpaYGxd2x3MWC16gqsbese919tBmENYYlmzX4dM999tOfwKwgyPzgB6HATTz+S3
         wronfPxno4Qr55Rh9DcQKchxwDxHPAtJIat5c8YL8DrtYSuss1ighIDPJQU/LtSxKwK0
         OAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pYmNdn17WaFVbSZzxAjZrcjydk4+7qcEdKI8uYhDoCc=;
        b=UJbF19Hc77Giu1/4opsUhw/UrNrReDGNTbEBxhfIJO8O3YmzoEnSLpLBrR2+nkJoFt
         f1zHn+ae+ESmUh2xFE4U0CYJff718l8t94FlvLjynYqwMmi6D6IACJ8sr9vdnYxeyMfi
         opJS1NSHeVDFqyj+S4ihmOfzqVTYf+nzEV95dohEeqalsjhRyhkBWUoQ/eUiauQI4jxO
         Q7g4p4v1jeMdyINyO/2jREXM318YvNmiFHrzvTgtKY8lUS3JI0pDrHFpSLAi132X5ucv
         GMBIzwYxOrn7ZtNV5Pwe/472iwqWO5LgKjUWikEimCxiBHH98Gxqrc3kqrK1FJTO5Vyc
         im+A==
X-Gm-Message-State: AOAM5332NRrTOHffF4v1BysIu5VWeUuEGiG2TpjAk07nRGoyiNwgKEMF
        L+dFstBTYLAzDM0varuz4lqomw+aeGyOF5/O
X-Google-Smtp-Source: ABdhPJw5GYEyra5w6QAs6I5t3xbqyitgTnBNohWeeKzzPl5kQG4tOKd7ZRWnxHQXCZEIRqiQCPL+rA==
X-Received: by 2002:a17:906:2504:: with SMTP id i4mr20151975ejb.297.1618823273539;
        Mon, 19 Apr 2021 02:07:53 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f19sm12521084edu.12.2021.04.19.02.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 02:07:52 -0700 (PDT)
Date:   Mon, 19 Apr 2021 10:07:50 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-pci@vger.kernel.org,
        alexander.shishkin@linux.intel.com, helgaas@kernel.org,
        gregkh@linuxfoundation.org, lorenzo.pieralisi@arm.com,
        will@kernel.org, mark.rutland@arm.com, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, song.bao.hua@hisilicon.com,
        john.garry@huawei.com, prime.zeng@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH RESEND 3/4] docs: Add HiSilicon PTT device driver
 documentation
Message-ID: <20210419090750.g6aeyyrki7fiotxl@maple.lan>
References: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
 <1618654631-42454-4-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618654631-42454-4-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 06:17:10PM +0800, Yicong Yang wrote:
> Document the introduction and usage of HiSilicon PTT device driver.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  Documentation/trace/hisi-ptt.rst | 326 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 326 insertions(+)
>  create mode 100644 Documentation/trace/hisi-ptt.rst
> 
> diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
> new file mode 100644
> index 0000000..f093846
> --- /dev/null
> +++ b/Documentation/trace/hisi-ptt.rst
> @@ -0,0 +1,326 @@
> [...]
> +On Kunpeng 930 SoC, the PCIe Root Complex is composed of several
> +PCIe cores. Each PCIe core includes several Root Ports and a PTT
> +RCiEP, like below. The PTT device is capable of tuning and
> +tracing the link of the PCIe core.
> +::
> +          +--------------Core 0-------+
> +          |       |       [   PTT   ] |
> +          |       |       [Root Port]---[Endpoint]
> +          |       |       [Root Port]---[Endpoint]
> +          |       |       [Root Port]---[Endpoint]
> +    Root Complex  |------Core 1-------+
> +          |       |       [   PTT   ] |
> +          |       |       [Root Port]---[ Switch ]---[Endpoint]
> +          |       |       [Root Port]---[Endpoint] `-[Endpoint]
> +          |       |       [Root Port]---[Endpoint]
> +          +---------------------------+
> +
> +The PTT device driver cannot be loaded if debugfs is not mounted.

This can't be right can it? Obviously debugfs must be enabled but why
mounted?


> +Each PTT device will be presented under /sys/kernel/debugfs/hisi_ptt
> +as its root directory, with name of its BDF number.
> +::
> +
> +    /sys/kernel/debug/hisi_ptt/<domain>:<bus>:<device>.<function>
> +
> +Tune
> +====
> +
> +PTT tune is designed for monitoring and adjusting PCIe link parameters (events).
> +Currently we support events in 4 classes. The scope of the events
> +covers the PCIe core to which the PTT device belongs.
> +
> +Each event is presented as a file under $(PTT root dir)/$(BDF)/tune, and
> +mostly a simple open/read/write/close cycle will be used to tune
> +the event.
> +::
> +    $ cd /sys/kernel/debug/hisi_ptt/$(BDF)/tune
> +    $ ls
> +    qos_tx_cpl    qos_tx_np    qos_tx_p
> +    tx_path_rx_req_alloc_buf_level
> +    tx_path_tx_req_alloc_buf_level
> +    $ cat qos_tx_dp
> +    1
> +    $ echo 2 > qos_tx_dp
> +    $ cat qos_tx_dp
> +    2
> +
> +Current value (numerical value) of the event can be simply read
> +from the file, and the desired value written to the file to tune.

I saw that this RFC asks about whether debugfs is an appropriate
interface for the *tracing* capability of the platform. Have similar
questions been raised about the tuning interfaces?

It looks to me like tuning could be handled entirely using sysfs
attributes. I think trying to handle these mostly decoupled feature
in the same place is likely to be a mistake.


Daniel.
