Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E93D34F5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhCaBLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhCaBKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:45 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD8C061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:10:45 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xx24d3z9t0k; Wed, 31 Mar 2021 12:10:36 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>, arnd@arndb.de,
        fbarrat@linux.ibm.com, linux-kernel@vger.kernel.org,
        ajd@linux.ibm.com
Cc:     rdunlap@infradead.org
In-Reply-To: <20210322023307.168754-1-unixbhaskar@gmail.com>
References: <20210322023307.168754-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] cxl: Fix couple of spellings
Message-Id: <161715298060.226945.13634069948401550126.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:40 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 08:03:07 +0530, Bhaskar Chowdhury wrote:
> s/filesytem/filesystem/
> s/symantics/semantics/

Applied to powerpc/next.

[1/1] cxl: Fix couple of spellings
      https://git.kernel.org/powerpc/c/e23ecdf9fd87c547a3ac55bcebaf7df28df2fab0

cheers
