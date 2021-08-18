Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F733F051D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbhHRNqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbhHRNqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:46:33 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF4DC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:45:58 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GqTgk1BXLz9sX2; Wed, 18 Aug 2021 23:45:53 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
Subject: Re: (subset) [PATCH 00/38] Replace deprecated CPU-hotplug
Message-Id: <162929392340.3619265.4687850442497311198.b4-ty@ellerman.id.au>
Date:   Wed, 18 Aug 2021 23:38:43 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 16:15:43 +0200, Sebastian Andrzej Siewior wrote:
> This is a tree wide replacement of the deprecated CPU hotplug functions
> which are only wrappers around the actual functions.
> 
> Each patch is independent and can be picked up by the relevant maintainer.
> 
> [...]

Applied to powerpc/next.

[03/38] powerpc: Replace deprecated CPU-hotplug functions.
        https://git.kernel.org/powerpc/c/5ae36401ca4ea2737d779ce7c267444b16530001

cheers
