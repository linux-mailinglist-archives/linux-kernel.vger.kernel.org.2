Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9604032BDE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350159AbhCCQj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:39:26 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:40132 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344703AbhCCMEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:04:04 -0500
Received: by mail-wm1-f45.google.com with SMTP id o2so5581510wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 04:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MgKg+xuFshcWxF/EWFStdvX3IMRA6xhZUH5DmSOHrFs=;
        b=ndQ5HhP9GKxt1nP6KAA/R6M1DU6ObNHUer0W6C2cz+mi/MzdBOZmKCSV3VQ5sXsmdq
         CHJiQd7o3gwK8BlyKGriSAhfZ5+ZSr0Si7Hw+mADDaEQi+sUNM6ejpPCbAdXH/KH5jiL
         Nq6IT+NE4y2Gz9HmVdoHBkxT0hZ0WBozTmcn4eSINM4suesKc7jgMjmN90vwShChSq96
         xdfvylaTKsxLlOxJg9BfVn7fwm34Xm19F57S0eYJHpdNAs9oGeP15bXE6do3YTkJqnDP
         2fBGdIuarCX0cU0B+597KdPlGDImo920n6bLcNKeJKypPD+zcK7kc/0W0Nm4f3ZjqavQ
         uIQg==
X-Gm-Message-State: AOAM5309b2RKe9luxf+x9CMGMwSpscGfE+snrDBMAL5GZ4O//JPZ1MWa
        7+H7hCGmGc0OfA2RtbUWL42eXcjU2VA=
X-Google-Smtp-Source: ABdhPJwbVQqhAFsa13auW4eF3yjMx+StH3dqVQPam9+Jh5V2R/AUGy6jdsUSjFw678Ny0MVLZodEFA==
X-Received: by 2002:a7b:cb90:: with SMTP id m16mr8770689wmi.162.1614772335253;
        Wed, 03 Mar 2021 03:52:15 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a75sm5914399wme.10.2021.03.03.03.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 03:52:14 -0800 (PST)
Date:   Wed, 3 Mar 2021 11:52:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH] Drivers: hv: vmbus: Drop error message when 'No request
 id available'
Message-ID: <20210303115213.h355ncqtezsigjxz@liuwe-devbox-debian-v2>
References: <20210301191348.196485-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301191348.196485-1-parri.andrea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 08:13:48PM +0100, Andrea Parri (Microsoft) wrote:
> Running out of request IDs on a channel essentially produces the same
> effect as running out of space in the ring buffer, in that -EAGAIN is
> returned.  The error message in hv_ringbuffer_write() should either be
> dropped (since we don't output a message when the ring buffer is full)
> or be made conditional/debug-only.
> 
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Fixes: e8b7db38449ac ("Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening")

Applied to hyperv-fixes.

Wei.
