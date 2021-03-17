Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8806E33F774
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhCQRsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:48:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37507 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbhCQRrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:47:45 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lMaGk-0000VS-Tx; Wed, 17 Mar 2021 17:47:43 +0000
Date:   Wed, 17 Mar 2021 18:47:42 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Xiaofeng Cao <cxfcosmos@gmail.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: Re: [PATCH] kernel:signal: Fix typo issue
Message-ID: <20210317174742.sdi3hcg57jgc6uvo@wittgenstein>
References: <20210317084652.12049-1-caoxiaofeng@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210317084652.12049-1-caoxiaofeng@yulong.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 04:46:52PM +0800, Xiaofeng Cao wrote:
> change 'situration' to 'situation'
> change 'delievered' to 'delivered'
> change 'overriden' to 'overridden'
> 
> Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
> ---

Thanks! (Self-detected or through some tool?)
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
