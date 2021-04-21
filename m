Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75769366C60
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbhDUNPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:15:50 -0400
Received: from ozlabs.org ([203.11.71.1]:49019 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242222AbhDUNJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:56 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FQLVV2DJpz9vFw; Wed, 21 Apr 2021 23:09:22 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210402001325.939668-1-tyreld@linux.ibm.com>
References: <20210402001325.939668-1-tyreld@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Add shutdown() to vio_driver and vio_bus
Message-Id: <161901050031.1961279.6886013508565602654.b4-ty@ellerman.id.au>
Date:   Wed, 21 Apr 2021 23:08:20 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 18:13:25 -0600, Tyrel Datwyler wrote:
> Currently, neither the vio_bus or vio_driver structures provide support
> for a shutdown() routine.
> 
> Add support for shutdown() by allowing drivers to provide a
> implementation via function pointer in their vio_driver struct and
> provide a proper implementation in the driver template for the vio_bus
> that calls a vio drivers shutdown() if defined.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries: Add shutdown() to vio_driver and vio_bus
      https://git.kernel.org/powerpc/c/39d0099f94390eb7a677e1a5c9bb56a4daa242a1

cheers
