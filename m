Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354DA32257B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 06:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhBWFke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhBWFkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:40:31 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA34CC06174A;
        Mon, 22 Feb 2021 21:39:50 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e9so9164890plh.3;
        Mon, 22 Feb 2021 21:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OQhXBHglD/xII0lAMa2hrFHnBcUAjONe9S0yyl2FFXA=;
        b=YDgAhXuLMYooOULnSXis+HK+Oxm3DS6EGYdGnvPBtMEr+ONO9AQfJo79hLRKFuUWls
         52r0+dU6o6NbQlM7viKK6zNXGu84VOBhoHxDgl30OC79vtkjt54pTw3n6g5qlOMJxyuV
         Jt9joxCajZhCB819JNRkFC4zu5+x9pzuF6Ad/gDBk81WGsZQVgtc/98qTb6j77snyt/y
         pSO8H8tjB0wZF3Z3hOEUTaQtcmpRzdY494MXuTurhDPJGes18ysnFCHrkxcTnuPx0FlQ
         uXieQCkV4QVR2a3qzS95tm/pxPnYJ+UBHRFvBnquH9DUZhafY8ccbULEXiqrWn0E6NOa
         qyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OQhXBHglD/xII0lAMa2hrFHnBcUAjONe9S0yyl2FFXA=;
        b=OwmHAG65ugIvkAN//elNEMgoxImSwO/5PaFFCqzjlwDaSzbjhzMFWa7UsNMX6prKT0
         Y8zgeV5Ql7oEJtfNM/HxXdfB/tH/kDr6K497L0DGaII4dZTz2tsUvPMY38HxXHC24bg3
         r3V89qRmK1k8ONOU748P2WbJiKABOx9AFE4a5F4M4innnMS0GfpK8IKB3HrwI+7xKO/f
         DBTXrFSjCVMkRdUDzIQT/RdxO9MeMci93/4rVuzvXRRqqUK6KpDerzWPEvOSMjiww/1j
         2lI5tk26K/lkWxwNPA9SglfmQ5+UjyD4SyRDoo/3a/s9XDSFRhsvmAUDk65Ya/wWfRFC
         WgLA==
X-Gm-Message-State: AOAM530KnJT+bhF7+Q467SxZ9jiU6xzTnlFvLFdOcAHgIcx3anXaedh7
        0F2adjOlbHTwAEW9nNAM/JQInIstFWc=
X-Google-Smtp-Source: ABdhPJzj6bc2ZJPBsKsarHyr+N1iAFQ4jNXjq7l1xvMYxtiY8FW9NZxVpmN2T6kf2xKPmPjKqgnCBw==
X-Received: by 2002:a17:902:9f8b:b029:e0:425:b856 with SMTP id g11-20020a1709029f8bb02900e00425b856mr26184322plq.82.1614058790396;
        Mon, 22 Feb 2021 21:39:50 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc19:4f46:855:edfc])
        by smtp.gmail.com with ESMTPSA id 15sm1485724pjn.20.2021.02.22.21.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 21:39:49 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:39:47 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, swboyd@chromium.org,
        dianders@chromium.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/3] dt-bindings: input: Fix the keymap for LOCK key
Message-ID: <YDSVI6vcxjMG6Cxe@google.com>
References: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
 <20210115143555.v6.3.I96134907488f41f358d03f3c1b08194f9547e670@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115143555.v6.3.I96134907488f41f358d03f3c1b08194f9547e670@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 02:36:17PM -0800, Philip Chen wrote:
> Decouple LOCK from F13 and directly map the LOCK key (KSI3/KSO9) to
> KEY_SLEEP action key code.
> 
> Signed-off-by: Philip Chen <philipchen@chromium.org>

Applied, thank you.

-- 
Dmitry
