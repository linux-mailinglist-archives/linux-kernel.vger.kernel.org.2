Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E684A33305E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 21:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhCIU5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:57:02 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:54228 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCIU4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:56:33 -0500
Received: by mail-wm1-f46.google.com with SMTP id e23so3783789wmh.3;
        Tue, 09 Mar 2021 12:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JFD+knxhbgjWL3eI/xavMNJfjLYJTwVKvjMVSZz9+6g=;
        b=lXjGX0q+WzNZwVEAk7ffDocmRPp8IR+b+a0lOLVaIELQMLKRC7qdO8M65e5a5zwsQV
         jYGhbzff0Ml4tfar8vESNHbi1s4m8DW9zAZqppKshaU2po6rtWg7xC9qIy8OzEM1hpQF
         LklI/kjL6rx3YPpQd3M1/D4NNhpZxLYNiuP1yu1ZVBYjk0gR4l+ovmYNzzQ2OP2Fcuqm
         2AqsBNeOkCEzO6L177Jv8Cj6S4G6x3xyByaAHfQoqPI3pna0ASf7DW5i+Sf05OBP/C06
         sBbxMqFi8ybK1loLPTMi8Hh5RlEfNZ52KMhYdua/m/xJJ8OhrW0T8j5dkoFTqEWjLI7P
         4gqw==
X-Gm-Message-State: AOAM533Bn2cR3easIhL0c8PM42uiFvrnIUZrcT9wGWpaX3ITO7tDfYFp
        d+x5BXGJZd8pJc0l2nuyLbQ=
X-Google-Smtp-Source: ABdhPJxNHh2Fj3Pxn1keVzJYAksuucsgzc3xGcO6rLV4pNx2sU2Y3jMmK8jBHUSODlQMS+vapZb6Dg==
X-Received: by 2002:a1c:9d51:: with SMTP id g78mr6226198wme.5.1615323392396;
        Tue, 09 Mar 2021 12:56:32 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id s3sm25072658wrt.93.2021.03.09.12.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 12:56:31 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: imx8mq: remove SoC ID compatible
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        alice.guo@oss.nxp.com
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
References: <20210104091544.13972-4-alice.guo@oss.nxp.com>
 <20210309134251.2583679-1-martin.kepplinger@puri.sm>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <d2030810-a307-0438-d4b0-be6aa092e551@kernel.org>
Date:   Tue, 9 Mar 2021 21:56:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210309134251.2583679-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2021 14:42, Martin Kepplinger wrote:
> this reverts commit ce58459d8c7f4174e7b8a8ea903dd949631334a3 for imx8mq.
> 
> this is most likely not the real fix but works around the problem I have
> (with v5.12-rc2) I want to report:
> 
> [    0.766925] SoC revision 0x21
> [    0.770286] imx8_soc_info soc@0: SoC revision via nvmem read failed: -517
> 
> This leads to the system not booting up.
> 
> This change makes use of the old way of reading soc_revision and thus
> works around the problem.
> 
> What could be missing for the nvmem way to work here? Should it work
> in any case? I assume so if you add the compatible to imx8mq.dtsi. But
> if it would work, why keep the ocotp reads?

Hi,

Thanks for the report. 517 is deferred probe, so this could mean that
efuse/ocotp did not come up yet. However soc_id driver should handle it
and re-try after some try, shouldn't it? Unless there is a bug inside
(your change basically disables soc_id driver).

Best regards,
Krzysztof
