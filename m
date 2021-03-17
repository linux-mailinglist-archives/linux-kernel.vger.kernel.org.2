Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9233F778
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhCQRtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:49:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37541 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhCQRsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:48:50 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lMaHo-0000cM-69; Wed, 17 Mar 2021 17:48:48 +0000
Date:   Wed, 17 Mar 2021 18:48:47 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Xiaofeng Cao <cxfcosmos@gmail.com>
Cc:     christian@brauner.io, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: Re: [PATCH] kernel:fork: Fix typo issue
Message-ID: <20210317174847.pwnfp2uelgwbazt4@wittgenstein>
References: <20210317082031.11692-1-caoxiaofeng@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210317082031.11692-1-caoxiaofeng@yulong.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 04:20:31PM +0800, Xiaofeng Cao wrote:
> change 'ancestoral' to 'ancestral'
> change 'reuseable' to 'reusable'
> delete 'do' grammatically
> 
> Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
> ---

Thanks!
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
