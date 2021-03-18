Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8907A3408F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhCRPfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:35:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42501 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhCRPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:35:03 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@canonical.com>)
        id 1lMuft-00039p-T5
        for linux-kernel@vger.kernel.org; Thu, 18 Mar 2021 15:35:02 +0000
Received: by mail-ed1-f71.google.com with SMTP id f9so17063641edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0CTA1Y3sluOT4Qsh6qv0jDY/lM9GSPSNXmGPaJY6Wu8=;
        b=sVCaOTEtdLeCf8oVS/b5KDhV5buzcGIXfyHVi2E8FM3EKHSlTC9lZ8GJdlSC38nHyz
         la7r8WVNPXFW7Vkssw+f8Gi48X8UQ8C3/1UUa9RWfsN7BOT9yFzA6Svewfd+5Fy2fcpQ
         Fv4v3jcSEOnDpd2Sg/wR/PCnRaOV5Yq3NZEUcxiqb5WfXBlbTBoTle8FbWNiQTM7iAZp
         iDmePrGqMj4B/jm06dqn0OIJQ+5scOzvtftvRP4aGe2+xs1DjbbGIp/qqC1VXzqwmCab
         vWFlsbeS6incoQZlcABn4wW4DdFRPNd+SgZFgtvAIEbndvcquMnjSYXzZW+ZApO91Ppw
         QWKQ==
X-Gm-Message-State: AOAM531OVX9yeDgNmJl+kJxzDju/ckp+g88nJNgjXOTT1yILtYSa5Wn4
        qdY6HTTeOTX9c9e1RnEjF0FLHRCza8MOoVmKJSIOtTPxH+zu1Fda/I0367dGTMpPio0vzoHh2hV
        6AXzfb8rg+dXrzkapPd3SFlR4YRoiro6evxRfQar3rQ==
X-Received: by 2002:a05:6402:484:: with SMTP id k4mr4307567edv.321.1616081701593;
        Thu, 18 Mar 2021 08:35:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyubUDKilDMndxbQbypUxRod+E8BeHn6ehiL2vZj7sJsP+2LHSLB41RjU20lobXHca6Lu241Q==
X-Received: by 2002:a05:6402:484:: with SMTP id k4mr4307544edv.321.1616081701369;
        Thu, 18 Mar 2021 08:35:01 -0700 (PDT)
Received: from gmail.com (ip5f5af0a0.dynamic.kabel-deutschland.de. [95.90.240.160])
        by smtp.gmail.com with ESMTPSA id u14sm2109344ejx.60.2021.03.18.08.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:35:01 -0700 (PDT)
Date:   Thu, 18 Mar 2021 16:35:00 +0100
From:   Christian Brauner <christian.brauner@canonical.com>
To:     Xiaofeng Cao <cxfcosmos@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: Re: [PATCH] fs/exec: fix typos and sentence disorder
Message-ID: <20210318153500.ntwnsdsptesbnfm5@gmail.com>
References: <20210318153145.13718-1-caoxiaofeng@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318153145.13718-1-caoxiaofeng@yulong.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 11:31:45PM +0800, Xiaofeng Cao wrote:
> change 'backwords' to 'backwards'
> change 'and argument' to 'an argument'
> change 'visibile' to 'visible'
> change 'wont't' to 'won't'
> reorganize sentence
> 
> Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
> ---

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
