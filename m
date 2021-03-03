Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C912532C115
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837943AbhCCS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:59:13 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:42673 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578002AbhCCSQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:16:15 -0500
Received: by mail-ej1-f42.google.com with SMTP id c10so17551901ejx.9;
        Wed, 03 Mar 2021 10:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L75O0W+60sA8PCw5vctCVfCnPFx9Df6RaLcl8AjpdUk=;
        b=KBTT0ez2c+18fHXUZ2+UWxOeMkeMa2GQ3BSjuMARJyu2Wl3wXelvn0g37uJwWuFbxq
         40BW3YewtWd7oWmArWmVbOKxPkG2NKtAMBkwqfhgw7N9XYmXRZOb8WNMX66cVENpWfdP
         ZqYIZAyIShYXnsks4tiAt2fpOwVtf+N7Xap3IJql/SgE2vcSE0ReInqJ8ndpMMDi/XAw
         fAO5bK2SWOxkxysGrjTd/6rrrcWaeozHAV+lP7rz2t7YVXmL4c+BW0B5crUM7CT3jCVB
         ymqxqg6NAInkqjR4/AYarA87mZ1icpSQDmW6sDAKZ2VMcayx+BtHiXdGlk/QFUBy6PFl
         Q7CQ==
X-Gm-Message-State: AOAM533LaoJ5IwhPEcsoEtk++OT6bVKjBkR3HoFRrMt0sIcSZ5UEWaYk
        Ysd2rkmKXOac64A9mMs8S0E=
X-Google-Smtp-Source: ABdhPJyv9ZHoKKrSfAYG3E0t2WiB0w2EQIFOB2iy2f5mHjXqT5rXzjkL15BWUuBoI/U9Tncs2D1Ixw==
X-Received: by 2002:a17:906:4c56:: with SMTP id d22mr110677ejw.426.1614795332589;
        Wed, 03 Mar 2021 10:15:32 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id t15sm19739654edc.34.2021.03.03.10.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 10:15:31 -0800 (PST)
Subject: Re: [PATCH 03/11] arm64: dts: intel: socfpga: override clocks by
 label
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
References: <20210210171823.333802-1-krzk@kernel.org>
 <20210210171823.333802-3-krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <e9a88bad-fb08-f028-bfe1-6d008dbfe1de@kernel.org>
Date:   Wed, 3 Mar 2021 19:15:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210210171823.333802-3-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2021 18:18, Krzysztof Kozlowski wrote:
> Using full paths to extend or override a device tree node is error
> prone.  If there was a typo error, a new node will be created instead of
> extending the existing node.  This will lead to run-time errors that
> could be hard to detect.
> 
> A mistyped label on the other hand, will cause a dtc compile error
> (during build time).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts   | 12 ++++--------
>   .../boot/dts/intel/socfpga_agilex_socdk_nand.dts     | 12 ++++--------
>   arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts      | 12 ++++--------
>   3 files changed, 12 insertions(+), 24 deletions(-)

Hi Arnd and Olof,

There was no response from Intel SoCFPGA maintainers for the DTS 
patches, so maybe you could take it directly? I can provide you pull 
request with these, if that's preferred. They apply cleanly.

You could also take the dt-bindings 2/11 or it could go via Rob.

About the defconfig patch (1/11) I will work on it more and resend it 
with your comments (you gave me review).

Best regards,
Krzysztof
