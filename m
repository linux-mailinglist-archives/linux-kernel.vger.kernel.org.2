Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BC03BB7E5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhGEHd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhGEHd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:33:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A859AC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 00:31:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso10642140wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 00:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9sf8cITdcw0A6VcauYEZ62Lf40LaTS26ptlIQ0Tews8=;
        b=OtNikveirLZPBZMaMZaVunIqPaiWgUh54q4A2MYJl5BUSpRDzfFr28k++rYpHN1a12
         nuhKfszCnuo1I7Z73dt1FC7A4a4LsGyS/KWlOgePS+y5om835oY8ex14YAT9eT1vsLGS
         f9UDFx+/vK0ji0FoNXWcAOk4x+knv1LBY46Qaz0Kmuy28YJGPVb6jKZ62sQkTkMVAYcW
         zuT310Bvv6NEccP/u5bkE3YMR0zgotDKra7aQ+zS/HbOJsEcMa+bCfgDXtOqBQ8QTgpz
         Jdx+EM5Bdu1fTMCoVNELQJvcsZxpGdzllZe2807iHpNhJ9ePq+uYUNDW7BB75s4wLdbX
         LnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9sf8cITdcw0A6VcauYEZ62Lf40LaTS26ptlIQ0Tews8=;
        b=WerAOxDjKaAj7PfFJXt/UiERPUkV/iieXcROjDyI2BS6qAgy4YzvwbF1kp0+/U7Ufg
         kq1Tkd56k/4UsXOEbbjbSSOsbinM7NKQGfWt+9sqhzQryIl5TMtTjBaXiBk2eFen2YR2
         WLIPCNXdqUaXOBby15F7OQQeuP+6CDsx6mW/+y3TSJdrs13hHhz2AU67dqNviHoYruFO
         x6F+pW1btMIXGlK6nieC3s8BOhB9BqeOovdpjJ3vmcQhf5YPNENmof/VPImepQ0qAt4H
         zQFGg2zR6qC+ybBT4bmTG2B2ngLcrKBtcAxn22v4qRHEZt9kPsWK82DoxBdanyvCJaut
         3HAw==
X-Gm-Message-State: AOAM5339GUdy2RaeeLR04lPlq5+Q1rp9MwsRVbf9HMzpQZk6RLFX5JvQ
        dqjeM9x8E+qtbT9ualisJ1+jxA==
X-Google-Smtp-Source: ABdhPJxYilrsPgCA3cgDP3VBZksHTEVOiDTNTEk64cp2asy1TM33l7YiSziqL4H+YT0em09Q94tmKA==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr13444544wmq.181.1625470277921;
        Mon, 05 Jul 2021 00:31:17 -0700 (PDT)
Received: from dell ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id j37sm8826787wms.37.2021.07.05.00.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:31:17 -0700 (PDT)
Date:   Mon, 5 Jul 2021 08:31:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yunus Bas <Y.Bas@phytec.de>
Cc:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Message-ID: <YOK1RvQI1rHvaXEy@dell>
References: <03cb3befabdda032b1ec9d97b4daac69fa23c759.camel@phytec.de>
 <YNsid9K4PdUJbKqs@dell>
 <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
 <20210630105557.eaktwdz5p6yzuron@maple.lan>
 <YNxktsFmlzLcn4+Y@dell>
 <9b5d0003cce92cad57e7712d1e46c78c10f1a0ab.camel@phytec.de>
 <20210702125920.fydyfhwqe7tyr7oi@maple.lan>
 <YN9cl1/7k/UlllSq@dell>
 <20210702191012.mecgw577ggkabxr6@maple.lan>
 <c2ca83c4d67a47a8e104e5c54a4920cac56312b1.camel@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2ca83c4d67a47a8e104e5c54a4920cac56312b1.camel@phytec.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jul 2021, Yunus Bas wrote:

> Thank you for the clarification. I'm now aware on how to handle MFD's
> in the devicetree. But given this, the default behavior of MFD's should
> definitely be documented since i could see many other devicetree
> examples handling this also not in the proper manner.

In the 8 years I've been working with DT and MFD, this is the first
time this particular issue has arisen, but if you'd like to submit
such a document, it will be considered for inclusion.

Really pleased you have this figured out though.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
