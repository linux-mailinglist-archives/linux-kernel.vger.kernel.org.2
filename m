Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7031710E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhBJURq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:17:46 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:34404 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbhBJURi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:17:38 -0500
Received: by mail-ot1-f45.google.com with SMTP id y11so3075594otq.1;
        Wed, 10 Feb 2021 12:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZXsyAUgNpQ7MKm5gpNUdWcFNxxOrvuvI1ZTaGnmXF78=;
        b=rVWc2+ENEy7FdlL3Awcq7lj/tWnQgxUeJSMTRPz2lT1N+jF3a9EduSLmhsgwKgh1JU
         GDafBPq/mhO46VgC/H3W7/E9Xmf1pYBFWkBiKkdpSSb7X7J0GqmSLTDUCUlg3mEJK662
         3kVW1YPcT63YwyiRSXKPcuhXGrVq2FRXNlcahlF9cUfMsYjIIslWF+RfLw4ryRzRXrZV
         AC7Q8VYrEzphEOi/KyY0FaVrTDk04w7JA1Vswm22+IkCLYse2nJQ6ABvS07qLRZsaRHl
         c0ir8/NOMWtXTlhrTAu8WZO6r17FUtTYu5bfvkAocqDDjfuVrRtCWlecAItGLc3qi1oh
         DSPA==
X-Gm-Message-State: AOAM531rZg64XNvlHAWkFqO2GzUxYfV7b92zfrAaPJ0O1D6wWE7anSmr
        mODkgQV4lo/KCLAze8bjIA==
X-Google-Smtp-Source: ABdhPJwUOUeHGJSiGCowqI6v+JsevRF/BUPkVWmYhpXW5eZR8ZqZRK8RdpUyMIAkkbbMnorumr+sNA==
X-Received: by 2002:a9d:3625:: with SMTP id w34mr3405528otb.330.1612988218236;
        Wed, 10 Feb 2021 12:16:58 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e17sm614219otf.32.2021.02.10.12.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:16:57 -0800 (PST)
Received: (nullmailer pid 2686353 invoked by uid 1000);
        Wed, 10 Feb 2021 20:16:56 -0000
Date:   Wed, 10 Feb 2021 14:16:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 1/7] ASoC: qcom: dt-bindings: add bindings for lpass
 rx macro codec
Message-ID: <20210210201656.GA2686235@robh.at.kernel.org>
References: <20210210093055.18350-1-srinivas.kandagatla@linaro.org>
 <20210210093055.18350-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210093055.18350-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 09:30:49 +0000, Srinivas Kandagatla wrote:
> This binding is for LPASS has internal codec RX macro which is
> for connecting with SoundWire RX codecs like WCD938x.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-rx-macro.yaml   | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
