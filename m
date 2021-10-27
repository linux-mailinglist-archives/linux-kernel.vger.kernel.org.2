Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D921F43C1FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 07:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbhJ0FE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 01:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230349AbhJ0FE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 01:04:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3765060F21;
        Wed, 27 Oct 2021 05:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635310922;
        bh=wg2RNG7Fk6M43nRwVMIjou4UKMRQPMXmVEw6LZZ3p44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOCwXYtLidTIun78mfD71bjvQM+xj6hxNp529AHSZKIqjF31Z/F64L8YPsbLtwk27
         1RK8grKv8pB3+zX/MK0jUeUBzf6lhiOMWk1UBBKNwu9/oQ5pPRmgq7ByWn81Qd455y
         EP2qtjzVPJByc/msCAuIPSWKL554WuDaO0MUyZV0=
Date:   Wed, 27 Oct 2021 07:01:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_core: get rid of typedef
Message-ID: <YXjdRYCoqlx26MZq@kroah.com>
References: <20211026212756.25557-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026212756.25557-1-gascoar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 06:27:56PM -0300, Gaston Gonzalez wrote:
> Get rid of typedef and use proper kernel type instead.

which typedef?  Please be specific.

thanks,

greg k-h
