Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2BE45D799
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354243AbhKYJwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348778AbhKYJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:50:49 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE02C061746;
        Thu, 25 Nov 2021 01:47:38 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J0Cj45ZLFz4xcs;
        Thu, 25 Nov 2021 20:47:36 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1448051604-25256-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1448051604-25256-1-git-send-email-Julia.Lawall@lip6.fr>
Subject: Re: (subset) [PATCH 0/6] add missing of_node_put
Message-Id: <163783295820.1228879.10682208282272545718.b4-ty@ellerman.id.au>
Date:   Thu, 25 Nov 2021 20:35:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2015 20:33:18 +0000, Julia Lawall wrote:
> The various for_each device_node iterators performs an of_node_get on each
> iteration, so a break out of the loop requires an of_node_put.
> 
> The complete semantic patch that fixes this problem is
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @r@
> local idexpression n;
> expression e1,e2;
> iterator name for_each_node_by_name, for_each_node_by_type,
> for_each_compatible_node, for_each_matching_node,
> for_each_matching_node_and_match, for_each_child_of_node,
> for_each_available_child_of_node, for_each_node_with_property;
> iterator i;
> statement S;
> expression list [n1] es;
> @@
> 
> [...]

Patch 5 applied to powerpc/next.

[5/6] powerpc/btext: add missing of_node_put
      https://git.kernel.org/powerpc/c/a1d2b210ffa52d60acabbf7b6af3ef7e1e69cda0

cheers
