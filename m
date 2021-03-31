Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2933534F5E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhCaBK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbhCaBKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:25 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75672C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:10:25 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xb26s4z9sWP; Wed, 31 Mar 2021 12:10:23 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     gregkh@linuxfoundation.org, fbarrat@linux.ibm.com, arnd@arndb.de,
        ajd@linux.ibm.com, Laurent Dufour <ldufour@linux.ibm.com>
Cc:     clombard@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210310174405.51044-1-ldufour@linux.ibm.com>
References: <20210310174405.51044-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH] cxl: don't manipulate the mm.mm_users field directly
Message-Id: <161715297019.226945.4500799127424127385.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:30 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 18:44:05 +0100, Laurent Dufour wrote:
> It is better to rely on the API provided by the MM layer instead of
> directly manipulating the mm_users field.

Applied to powerpc/next.

[1/1] cxl: don't manipulate the mm.mm_users field directly
      https://git.kernel.org/powerpc/c/2d9f69bc5a5a75579b410beb0dc3d313be762c9f

cheers
