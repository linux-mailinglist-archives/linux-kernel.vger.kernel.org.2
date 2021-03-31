Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E8034F5D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhCaBKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:34 -0400
Received: from ozlabs.org ([203.11.71.1]:41039 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232874AbhCaBKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:12 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XL5cZdz9sWQ; Wed, 31 Mar 2021 12:10:10 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <a1e552006b8c51f23edd2f6cabdd9a986c631146.1615380184.git.christophe.leroy@csgroup.eu>
References: <a1e552006b8c51f23edd2f6cabdd9a986c631146.1615380184.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/Makefile: Remove workaround for gcc versions below 4.9
Message-Id: <161715297701.226945.17440071466886747895.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 12:43:12 +0000 (UTC), Christophe Leroy wrote:
> Commit 6ec4476ac825 ("Raise gcc version requirement to 4.9")
> made it impossible to build with gcc 4.8 and under.
> 
> Remove related workaround.

Applied to powerpc/next.

[1/1] powerpc/Makefile: Remove workaround for gcc versions below 4.9
      https://git.kernel.org/powerpc/c/802b5560393423166e436c7914b565f3cda9e6b9

cheers
