Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4FD3B312A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhFXOXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXOXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:23:41 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD35C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 07:21:21 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 700CBAF5C1D;
        Thu, 24 Jun 2021 16:21:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1624544479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0R0QEF73YuTurA+IxLTN/8XjMbBFMs4qR/f/X8p/UY=;
        b=Az+K1tStRAP79UNI+GBoSte0w9UNXju/TtxXCJvJmpziWQli3VQKCrp8RrtMPLBIXblCvW
        xaoDB5QUeCWbS+I+9iVYKxRQXT9cdVTmBID+3AijJmKortiMxS9vvYd7GZot/XubQFQwph
        flKuRa57wdy9M8VbQpJXuYkDtiZ9hz4=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org, "R.F. Burns" <burnsrf@gmail.com>
Subject: Re: PC speaker
Date:   Thu, 24 Jun 2021 16:21:17 +0200
Message-ID: <3050675.vmiHnzoCQa@spock>
In-Reply-To: <CABG1boMsJ+8OaLPmFcNZPRVPRRxd9gasxjZNwUy_3FD07XXO8A@mail.gmail.com>
References: <CABG1boMsJ+8OaLPmFcNZPRVPRRxd9gasxjZNwUy_3FD07XXO8A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On =C3=BAter=C3=BD 15. =C4=8Dervna 2021 5:32:32 CEST R.F. Burns wrote:
> Is it possible to write a kernel module which, when loaded, will blow
> the PC speaker?

Yes. Wanna help with that?

=2D-=20
Oleksandr Natalenko (post-factum)


