Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F293577D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 00:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhDGWj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 18:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhDGWjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617835150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RNasGRICqS6NJiBxRNH7M3e6SxbYtc76TWY+YxUdPJQ=;
        b=VJ0NWkNpXP5AQ8JyWb8nrKZO0wsQ+LqDIp/V6182HA19pOXuWS7es2MqsFQciNuSogmvie
        CT7YfwUgnqMKIfeCVJSmkCZg4yW7D22DUMhFIkQq1VMlI/ZF/fB9VZT4o9lxkctvKFXwF+
        THIAVJZc68fNxzSGaZy2+ReuiUZRtyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-h_7rBo_JPUGEyMxa_5P5PA-1; Wed, 07 Apr 2021 18:39:08 -0400
X-MC-Unique: h_7rBo_JPUGEyMxa_5P5PA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03734107ACC7;
        Wed,  7 Apr 2021 22:39:08 +0000 (UTC)
Received: from treble (ovpn-119-205.rdu2.redhat.com [10.10.119.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74C751002388;
        Wed,  7 Apr 2021 22:39:07 +0000 (UTC)
Date:   Wed, 7 Apr 2021 17:39:05 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ramakrishna Saripalli <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 0/5] Introduce support for PSF mitigation
Message-ID: <20210407223905.5dqgzdaibvgq7jeq@treble>
References: <20210406155004.230790-1-rsaripal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210406155004.230790-1-rsaripal@amd.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 10:49:59AM -0500, Ramakrishna Saripalli wrote:
> Because PSF speculation is limited to the current program context,
> the impact of bad PSF speculation is very similar to that of
> Speculative Store Bypass (Spectre v4)
> 
> Predictive Store Forwarding controls:
> There are two hardware control bits which influence the PSF feature:
> - MSR 48h bit 2 – Speculative Store Bypass (SSBD)
> - MSR 48h bit 7 – Predictive Store Forwarding Disable (PSFD)
> 
> The PSF feature is disabled if either of these bits are set.  These bits
> are controllable on a per-thread basis in an SMT system. By default, both
> SSBD and PSFD are 0 meaning that the speculation features are enabled.
> 
> While the SSBD bit disables PSF and speculative store bypass, PSFD only
> disables PSF.
> 
> PSFD may be desirable for software which is concerned with the
> speculative behavior of PSF but desires a smaller performance impact than
> setting SSBD.

Hi Ramakrishna,

Is there a realistic scenario where an application would want to disable
PSF, but not disable SSB?

Maybe I'm missing something, but I'd presume an application would either
care about this class of attacks, or not.

-- 
Josh

