Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE071356E09
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352721AbhDGOBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242411AbhDGOBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:01:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61544C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 07:01:03 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08fb003d0de1fbb4cfc493.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:fb00:3d0d:e1fb:b4cf:c493])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0AFD1EC03CE;
        Wed,  7 Apr 2021 16:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617804061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9Pi1SiCiKBHkqYBWx4f7tD5X6WAR0RI6rb1KfomUzAs=;
        b=DaZ2i331glQbTaCzNFLxHCxFby305PnBKsI/tdCcf3bw3eHvNDQ6CHJErsaFmoO71RLKJJ
        KLESBsUjO8JHUrZSGspfcxCg/9T+X1kxLKFQ3Kx92sZNIOkgOSDHNvcfE2eMZHJ5rXf38T
        tnPxyu/iGv3L/M2EAJ7ftvuO9VmoMRQ=
Date:   Wed, 7 Apr 2021 16:01:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ramakrishna Saripalli <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com
Subject: Re: [PATCH 0/5] Introduce support for PSF mitigation
Message-ID: <20210407140100.GE25319@zn.tnic>
References: <20210407124948.242399-1-rsaripal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407124948.242399-1-rsaripal@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 07:49:48AM -0500, Ramakrishna Saripalli wrote:
> From: Ramakrishna Saripalli <rk.saripalli@amd.com>

It seems you're new to this kernel development thing.

While you're waiting for your patches to be reviewed
fully and properly, please take the time to read
Documentation/process/submitting-patches.rst and all the others in
Documentation/process/ which explains how this whole game works.

For example:

"Once upon a time, patches used to disappear into the void without
comment, but the development process works more smoothly than that
now. You should receive comments within a week or so; if that does not
happen, make sure that you have sent your patches to the right place.
Wait for a minimum of one week before resubmitting or pinging reviewers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- possibly longer during busy times like merge windows."

Feel free to ask questions if something's unclear.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
