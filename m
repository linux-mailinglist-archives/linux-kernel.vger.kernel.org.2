Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC07433D336
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbhCPLil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234006AbhCPLiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:38:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B68F64FF4;
        Tue, 16 Mar 2021 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615894688;
        bh=3jTlW3m0IyZ00Sk3hvraqB7V7D2ALLZ27FCreaKJSiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsVD5oLAotdRlEbk4WerTqxiP5YdPAtklus0sE6iMIlmB70pLg6zzbG6uVIQepXnK
         9CVY+ChKeoX82GQb/Wf6/EeH8k3RiwQvKd5xs1YyuT7nQ1364W2yeea/26x7Tv7C9K
         axBR1elEXdmPNtt244DlkIfG6uTJiwuZh1uy820w=
Date:   Tue, 16 Mar 2021 12:38:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hao Peng <penghaob@uniontech.com>
Cc:     ross.schm.dev@gmail.com, izabela.bakollari@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: add empty line in general.c
Message-ID: <YFCYnXhZsFd7b+pd@kroah.com>
References: <20210315111220.27090-1-penghaob@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315111220.27090-1-penghaob@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 07:12:20PM +0800, Hao Peng wrote:
> Add one empty line upon return for easy reading.

Why?  Is this really needed?

