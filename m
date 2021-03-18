Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742DA340A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhCRQhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:37:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:52030 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232134AbhCRQhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:37:24 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E2D732E5;
        Thu, 18 Mar 2021 16:37:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E2D732E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616085444; bh=pWbzF1wgIUiO8lLs6lJoTFe088GpnU5XVDRIVFq/5Ok=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=e48pDaT9fmQ8ixzvsSt301dPeftXj1BshL6H+kPC2MY4a6u0bbOAMG4LNpdSgJstY
         sFXGk34Yr/N8e6t3VUsM2rCY5hxqBaF3gQvBXQuhcv85gVG2FrmwttrZH6LnONjHq2
         9xezEugy1o4JuPHcj4sCcFyhFrcbwWunDddU/QtI7jsyCx4+xgU5Y1oydtDO37lxD1
         E9oMvfouS4woufuQya2qosW04wCJITiQprm/D9jlbmtBT2GwPUswd+E8N8ZJY1CJ2g
         z6qLze5ecujERovNo3M3BgdgQSYVeJLsEPUXN/0vN/vKCzKgg0zm2I5OLyhoKMfIDe
         u3WwinKUwyxiA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Aditya <yashsri421@gmail.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
In-Reply-To: <CAKXUXMzwTp1H_vokVEAJSnmm7jNHfWzhhmLfpcrrBD9b8ak+dA@mail.gmail.com>
References: <20210309125324.4456-1-yashsri421@gmail.com>
 <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
 <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com>
 <871rcg2p8g.fsf@meer.lwn.net>
 <CAKXUXMzwTp1H_vokVEAJSnmm7jNHfWzhhmLfpcrrBD9b8ak+dA@mail.gmail.com>
Date:   Thu, 18 Mar 2021 10:37:23 -0600
Message-ID: <878s6kto3g.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> I wonder if we could extend kernel-doc (not your preferred option as
> it seems) for a new dedicated warning message or maintain a separate
> kernel-doc sanity checking script to emit a dedicated warning based on
> some heuristics that suggests when a "header comment" is probably
> unintentionally declared as a "kernel-doc comment" when it really
> should not be.
>
> Jonathan, would you then prefer to have a separate kernel-doc sanity
> checking script that then allows us to maintain checking for patterns
> we already cleaned up?

Having a warning in kernel-doc for "This comment starts with /** but
isn't a kerneldoc comment" could be useful, I guess.  That is the real
problem, not the fact that it appears at the top of the file.  I'm all
for tools that help us to clean things up, but let's not add
line-counting hacks to try to paper it over.

Thanks,

jon
