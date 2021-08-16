Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB27F3ED47D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhHPNCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhHPNCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:02:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2A3C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:01:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cq23so8962085edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/GF146nQqp2PhpJ6ztsdUf2MFA6TI0c/YyPE5i3rWg=;
        b=Kv1VN0BT3FxD3LkbsJLmMC26j4eip3NJXB+o/zrrjNYED2aEVccBpxVY6QJ7EJXIV0
         YQ4sjPo/t9+DbH0EuomMUE+nTU8iptuN7/xXU+S2xmdo6ZfxHCp+eqPzNMBYWt0Xaa0Q
         iDgWOaq9T6bKrQumJ+BcoUSQi4NsUFwk0JviFUA2XO6UNk1Kx0LH1A7OtL7hwL1ecGTl
         Jv0OTrnblF82yJ3DvSOudENG2GxDPAigYbMIAP6RlJbq8q5shkmsNoT1y5j4tOg4JA3Z
         I7qMuwY0dH1EEaXR3mGhNwJH5v9rVGlpP/ximSyMQxBPD6a7Co906xfxevORX79YHaPf
         cgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/GF146nQqp2PhpJ6ztsdUf2MFA6TI0c/YyPE5i3rWg=;
        b=kxMn0/uaMaUTNDQ6F0N6KP31TDb4AuGCHBYtsrB2EJmA8X5yv15OD9n988JLjg5NOz
         wcrq59DzQBMN0xnC975ipeYkFKTmWYXZeatWiPiBdGrH2kF/63DkI0bcC1/my9C7jUOs
         UNQ5XWaAWaDy2jFZkKnhrMbRqX/Om1hbb3UdAaDngXFA+k/cXwpi9PlOLsK6RYGOU8KF
         F3atwJd+sY2aJAwtWSf9h/+YUYq7icDqJYXSfypi/wsPsUHnp0reIS0O7y/+9uMfw2+D
         N+BIQxkLmSKYFVToKQtfpWhoBrFNn0pbQCrl80UK7YBgqzjXvWMgp6yhrhTbQLn3VOXJ
         yUHQ==
X-Gm-Message-State: AOAM530I3C1fjj7oz+b3zIuhn1XyVlDBABiSsQswNpuz7k0LlNOf8QCP
        xMjmsmkWXBULaygs31a7WUk=
X-Google-Smtp-Source: ABdhPJxof+bTIruXpbIJCpbwPvbI/t1rMO5oMHrf6faUO4UkAc6NNpP6eYZulvrURyJPodQq1gGquA==
X-Received: by 2002:a05:6402:31bc:: with SMTP id dj28mr19977771edb.143.1629118891817;
        Mon, 16 Aug 2021 06:01:31 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id f16sm4873904edw.79.2021.08.16.06.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 06:01:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: Re: [PATCH v2 2/4] staging: r8188eu: convert rtw_is_cckrates_included() to bool
Date:   Mon, 16 Aug 2021 15:01:29 +0200
Message-ID: <2093947.dRTFVrr4gv@localhost.localdomain>
In-Reply-To: <20210816115430.28264-2-straube.linux@gmail.com>
References: <20210816115430.28264-1-straube.linux@gmail.com> <20210816115430.28264-2-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 16, 2021 1:54:28 PM CEST Michael Straube wrote:
> Function rtw_is_cckrates_included() returns boolean values.
> Change the return type to bool to reflect this.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> v1 -> v2
> Rewritten to apply with v2 of patch 1/4.

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio



