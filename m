Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE6363A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhDSEHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:07:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52059 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237454AbhDSEFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:05:21 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVt45cXz9vHc; Mon, 19 Apr 2021 14:04:37 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210211182435.47968-1-tyreld@linux.ibm.com>
References: <20210211182435.47968-1-tyreld@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: extract host bridge from pci_bus prior to bus removal
Message-Id: <161880480588.1398509.15016110780432522314.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 14:00:05 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 12:24:35 -0600, Tyrel Datwyler wrote:
> The pci_bus->bridge reference may no longer be valid after
> pci_bus_remove() resulting in passing a bad value to device_unregister()
> for the associated bridge device.
> 
> Store the host_bridge reference in a separate variable prior to
> pci_bus_remove().

Applied to powerpc/next.

[1/1] powerpc/pseries: extract host bridge from pci_bus prior to bus removal
      https://git.kernel.org/powerpc/c/38d0b1c9cec71e6d0f3bddef0bbce41d05a3e796

cheers
