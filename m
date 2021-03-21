Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA88343462
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCUTz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 15:55:27 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:38022 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCUTzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:55:22 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7B85D92009C; Sun, 21 Mar 2021 20:55:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 713E992009B;
        Sun, 21 Mar 2021 20:55:17 +0100 (CET)
Date:   Sun, 21 Mar 2021 20:55:17 +0100 (CET)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/3] ata: Module parameter clean-ups for pata_legacy and
 pata_platform
Message-ID: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 In the course of looking into Christoph's recent proposal to drop legacy 
IDE drivers I have come across a number of issues with module parameters 
of the pata_legacy and pata_platform drivers: errors in documentation 
present in the comment form, missing user-visible documentation, and 
unconditional poking at ISA I/O ports in pata_legacy that isn't there with 
the old ide-generic driver (the lack of `probe_mask' parameter).

 Here's a small patch series that addresses these issues.  Overall I 
find the design of the pata_legacy driver's options a bit messy, e.g. the 
`all' vs the `probe_all' parameter, and the interpretation of masks where 
bits correspond to probed PATA locations in a particular system (rather 
than either all known or all existing), but it's been there long enough I 
think we have to keep it, so I merely tried to describe the current 
semantics.  See the individual change descriptions for details.

 The changes have been run-time verified with an EISA system and a single 
ISA PATA adapter at the usual primary I/O location.  They have also been 
verified (mainly for the correctness of MODULE_PARM_DESC use) with an 
x86/PC build (for pata_legacy) and a MIPS/SWARM build (for pata_platform).

 Please apply.

  Maciej
