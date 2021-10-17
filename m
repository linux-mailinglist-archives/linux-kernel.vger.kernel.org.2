Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA344309B1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 16:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343842AbhJQOPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 10:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbhJQOPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 10:15:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BD7C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:13:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i20so58859194edj.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I0IAJoaBZmIRDLA63S/As9EB+waQC7xkM4RWIrSSIrY=;
        b=RTYroCFLPFfML5sobEP6AIp0l+gbcHfRF3qn1o4puD+3Va8BO+Foh3eADcEVXk5U/+
         D0/4M+gIiuT2q7kSbtvXfpGwjbRwoCbeK0c37EhQ8HicryCapNvNfortuzG0n23/a+XO
         mBnRW/tbnWgsElQjhOJvN7uYkMoyymMrI0GCGttNlSdPsvuX60Y7PpwVbkToMDaI9j+S
         lBHsRtXrdEKVTByVZ7lABxYTeJSku87SNZ0MfNjtMRENVImSAPZqowCsxhSEOukpcfy9
         tgWl+v44s1YjqrmJ1djQTQfm9o0i9nnKRgwsXhwVz1f2OFJslMehSd7RykK1h+G597PY
         sV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I0IAJoaBZmIRDLA63S/As9EB+waQC7xkM4RWIrSSIrY=;
        b=a0L+AOww33DBrEIn2Rr9OOIT04Go4qsk/f9EzyrtnCe+ZgRyFeD+9+CZ1TouvsZu90
         SvDZyh5DT//G8NnYapax+jZC+KcSxFXTzGXj2G3aI4dpCc98qtSY7sQk0HvnwsvasoMg
         6ZYj45pxe7u3HDAVAb869eYYpxnEjhiSQR6gDvRyU6l2uGUHdw8n+99ow6Xty/E9JTy3
         v76BRpK0QEmABJb6BOQgY+d2qtovxadNwAT/psIQzJpZDV5ftfd3Rbh+H1ngDAlg38Mr
         OOo8SPaDwxxJqGViTLOmKlpks3ZIZ/mE4Ehp84mpEecf8lZR44NxEWIGLy61aVWyB2Rg
         +rGw==
X-Gm-Message-State: AOAM5317XG/tXa8RD73ESdqWt0n1jQSHg7H/g0A3rxLCvmJzOkovF+ct
        vug3UH497prxDzwyy269nDs=
X-Google-Smtp-Source: ABdhPJw+zwt4P/xwDaZdb3nL4pkZUL7UtcuafdxE4UhFhjiGOOojOIwznGer5TKd7zQHVPMRcQvSUA==
X-Received: by 2002:a17:906:1cd1:: with SMTP id i17mr22345686ejh.205.1634480002685;
        Sun, 17 Oct 2021 07:13:22 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id t15sm8336554ejx.75.2021.10.17.07.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 07:13:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: r8188eu: don't accept SIGTERM for cmd thread
Date:   Sun, 17 Oct 2021 16:13:20 +0200
Message-ID: <11761221.DPQ3dUVypB@localhost.localdomain>
In-Reply-To: <1957621.GeRc3qvyWe@localhost.localdomain>
References: <20211016181343.3686-1-martin@kaiser.cx> <YWv67ozbJGxMa69t@equinox> <1957621.GeRc3qvyWe@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, October 17, 2021 2:51:40 PM CEST Fabio M. De Francesco wrote:
> On Sunday, October 17, 2021 12:29:02 PM CEST Phillip Potter wrote:
>
> 
> Correct.

Please disregard this second mail. It is a duplicate due to some weird KMail 
crashes.

Fabio


