Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9492E3BBEB1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhGEPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:16:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59388 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhGEPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:16:01 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1m0QHj-0007Sy-1g
        for linux-kernel@vger.kernel.org; Mon, 05 Jul 2021 15:13:23 +0000
Received: by mail-ed1-f69.google.com with SMTP id i8-20020a50fc080000b02903989feb4920so3770957edr.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 08:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7HXLCPSoU2ku5Z25x/c/7Afb0RvzkTlC09xs4+z78F4=;
        b=amfqyvosyKtSciH+KSMQ5Vx5AWD9cbzc71Tid7WRzxaQoWiRvcUKf9TWAyDVR5Ze1A
         V1OHEm2HYU7QC6vfR1UK/p7wS1qji+jbZ48RJCfltpZdNNkJeq0cabN4mUt95jt61ePf
         ZzbUeVkcEe20KV3NBl6j6+grAccy1rboddzzjXlV35q5NcxPXUEn371Uch2IEA80PvBi
         ktWLDLmFDZeaMNed6CpfehSjQ+sCWzwyLEGGCBXAVthpawTGF+bngDpzrYQWbxvQkXGk
         cKfTsNaZTC/ZMnKwv0F19KWx/wTQ7RB+oh3RZxhVFOeZHGXtSOrsKluNAip9a3RN1Vq+
         nhFg==
X-Gm-Message-State: AOAM531kXeCiEVbRNDH0Q5qBsXaAv41vPX/4k/A0gic9leAQjQL4rvwc
        XS9CJl1m9IPB2duOjc1kTq2iNJjeqFJ4LM3vMzpx2DYzGo5pn+u6DD0bDP3TxDzkIS3gFhcP453
        ZbkYKhDPl8f8DPQkEN5JMkMzJ9m/3q0Fznu1i7iYIjg==
X-Received: by 2002:a05:6402:204:: with SMTP id t4mr16842386edv.34.1625498002783;
        Mon, 05 Jul 2021 08:13:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEBSAhhUehUatN39q10BAqmQC9QTSYyb9SbUpH2qnPy7k6MqtbBUwfOrKncFM/WsxjkNCpUQ==
X-Received: by 2002:a05:6402:204:: with SMTP id t4mr16842367edv.34.1625498002669;
        Mon, 05 Jul 2021 08:13:22 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id br4sm4348512ejb.110.2021.07.05.08.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 08:13:22 -0700 (PDT)
Subject: Re: [PATCH] EDAC, altera: skip defining unused structures for
 specific configs
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
References: <20210601092704.203555-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <b60d6dc2-abc2-b0fc-a880-1a7fec1dec67@canonical.com>
Date:   Mon, 5 Jul 2021 17:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210601092704.203555-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2021 11:27, Krzysztof Kozlowski wrote:
> The Altera EDAC driver has several features conditionally built
> depending on Kconfig options.  The edac_device_prv_data structures are
> conditionally used in of_device_id tables.  They reference other
> functions and structures which can be defined as __maybe_unused.  This
> silences build warnings like:
> 
>     drivers/edac/altera_edac.c:643:37: warning:
>         ‘altr_edac_device_inject_fops’ defined but not used [-Wunused-const-variable=]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/edac/altera_edac.c | 44 ++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 18 deletions(-)

Hi Altera and EDAC maintainers,

Any comments on this patch?

Best regards,
Krzysztof
