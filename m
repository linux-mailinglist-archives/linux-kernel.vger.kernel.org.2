Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413A5442CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhKBLmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:42:14 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:53263 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhKBLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7G82qmLz4xdh;
        Tue,  2 Nov 2021 22:38:56 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Wan Jiabing <wanjiabing@vivo.com>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Rob Herring <robh@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     kael_w@yeah.net
In-Reply-To: <20211018015418.10182-1-wanjiabing@vivo.com>
References: <20211018015418.10182-1-wanjiabing@vivo.com>
Subject: Re: [PATCH] powerpc/kexec_file: Add of_node_put() before goto
Message-Id: <163584789386.1845480.15708665136918587423.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:33 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021 21:54:16 -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./arch/powerpc/kexec/file_load_64.c:698:1-22: WARNING: Function
> for_each_node_by_type should have of_node_put() before goto
> 
> Early exits from for_each_node_by_type should decrement the
> node reference counter.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kexec_file: Add of_node_put() before goto
      https://git.kernel.org/powerpc/c/7453f501d443c7febf48809ee1c530b64d625c59

cheers
