Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3245813B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 00:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbhKTX73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 18:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbhKTX7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 18:59:04 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6F9C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:56:00 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso2201924ota.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 15:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4copcHXbsneyrgq1YuVzWaw1X/a0wnxrGicEVJDXfPY=;
        b=dEQktSa7vGkdP4ZYlMFOIRvthBRanJdmS3DccJBbSD8/+jpkYnMMS4U552kNhIedUO
         eXMHF+oo6ruhN5fscCJpsBv0I7gdypeCzL8PMGGheXhhNb5RbgGgjuxn/uDVGpD5htft
         4klFGt21l0mMbhvMCJgkHk0hlAYkxDubXoMpHEeGPxFDUG3A2ieeFqRkO5EmGX4qfIDq
         rWIQdLK/3gbG2ZO0oTKZ66k8OTHxWRsRzq544nXZRcPaV+oo8b3j9dmPlGyHuOideNh+
         zdm9GZkb0bBcmMuZI/L65h9ndQeYY7CaPTCWeLv5Ix7Vbt8sYncjbWADNSSHeMU+nb9o
         w3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4copcHXbsneyrgq1YuVzWaw1X/a0wnxrGicEVJDXfPY=;
        b=icII/1HXircV2/Morg2kwPRdd7ULPNm0LiWijzZLj3IxDcy49zDNb2B8Nre3WFMJ8I
         QPHm2qZSF4NG7tI8RWURvQXwS+Ir6THgAqciyekm/nKruHAjCF6o1ZxipcRz9AZQAR7H
         uqFDkYRCbGPF9bTj2cSO2u0TgyTsop77JrQ726pOMFvvLe+tghiqoio/tl8/Ylx0JDZC
         MjCS/Firg3szN2/a0h0C65o32/g6GdVW08SwdcRjUpRbSYZuPghviTmcuc8csvB3B6+e
         AXywEnITBHeGzP2N9D86ZUroN6eML3tsyrvVxhlvxmlxvkGpa4VyZeL2SCz1Re+92pDg
         gPSw==
X-Gm-Message-State: AOAM532YL1i7mcYyik85K/SDrBX5tdj4q+p/taYmP/c/pubLyGyFd77K
        P7MtGMMJobEpVxIJooVSvcJK8g==
X-Google-Smtp-Source: ABdhPJxh1VZurLxmfWPkmxcWUjKmLzuJopiTBiz2OhKjzE4r7YyWpiVJDeiXuqBHd3eTJ4oWPb/J5Q==
X-Received: by 2002:a9d:6a84:: with SMTP id l4mr5169832otq.216.1637452560169;
        Sat, 20 Nov 2021 15:56:00 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o26sm828474otj.14.2021.11.20.15.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 15:55:59 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: (subset) [PATCH] arm64: dts: qcom: msm8996-xiaomi-common: Change TUSB320 to TUSB320L
Date:   Sat, 20 Nov 2021 17:55:36 -0600
Message-Id: <163745250541.1078332.11199106407698362608.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211104111454.105875-1-y.oudjana@protonmail.com>
References: <20211104111454.105875-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2021 11:15:18 +0000, Yassine Oudjana wrote:
> This platform actually doesn't have TUSB320, but rather TUSB320L.
> The TUSB320 compatible string was used due to lack of support for
> TUSB320L, and it was close enough to detect cable plug-in and
> direction, but it was limited to upstream facing port mode only.
> Now that support for TUSB320L is added[1], change node name and
> compatible to match and allow it to be properly reset and have
> its mode set to dual-role port.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: msm8996-xiaomi-common: Change TUSB320 to TUSB320L
      commit: de0a2ae359ef9ccbaab86cce44d442cd0ca36985

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
