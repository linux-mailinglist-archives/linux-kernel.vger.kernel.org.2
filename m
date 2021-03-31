Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C012B34F5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhCaBLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbhCaBK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:29 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDB2C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:10:29 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xg0zxVz9sj1; Wed, 31 Mar 2021 12:10:27 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, menglong8.dong@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        paulus@samba.org, zhang.yunkai@zte.com.cn
In-Reply-To: <20210304031318.188447-1-zhang.yunkai@zte.com.cn>
References: <20210304031318.188447-1-zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH] arch/powerpc/include:fix misspellings in tlbflush.h
Message-Id: <161715296582.226945.7172443321891053719.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:25 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 19:13:18 -0800, menglong8.dong@gmail.com wrote:
> Some typos are found out.The information at the end of the file
> does not match the beginning.

Applied to powerpc/next.

[1/1] arch/powerpc/include:fix misspellings in tlbflush.h
      https://git.kernel.org/powerpc/c/1a029e0edbc5890f76b642222d9899c093212fe6

cheers
