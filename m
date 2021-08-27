Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C0A3F99E8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245439AbhH0NXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245237AbhH0NXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:23:31 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882EFC0612A7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:22:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0kZ19q8z9t5m;
        Fri, 27 Aug 2021 23:22:30 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Finn Thain <fthain@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <44ab381741916a51e783c4a50d0b186abdd8f280.1629334014.git.fthain@linux-m68k.org>
References: <44ab381741916a51e783c4a50d0b186abdd8f280.1629334014.git.fthain@linux-m68k.org>
Subject: Re: [PATCH] powerpc/tau: Add 'static' storage qualifier to 'tau_work' definition
Message-Id: <163007014335.52768.13507331045109682641.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:15:43 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 10:46:54 +1000, Finn Thain wrote:
> This patch prevents the following sparse warning.
> 
> arch/powerpc/kernel/tau_6xx.c:199:1: sparse: sparse: symbol 'tau_work'
> was not declared. Should it be static?
> 
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/tau: Add 'static' storage qualifier to 'tau_work' definition
      https://git.kernel.org/powerpc/c/6cd717fe9b3a787f8e8f9d0bc9b7634a9c104b3e

cheers
