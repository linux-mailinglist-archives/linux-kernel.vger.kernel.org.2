Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A21135B276
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 10:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhDKIjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 04:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhDKIje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 04:39:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1588D60C41;
        Sun, 11 Apr 2021 08:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618130357;
        bh=ptgz4PciJ8EZIH/tSNBSr2EiihonEzM+ZjH4HOcBJQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGOH+OCyfwx6BkX4ftG2DpPeHPSdvfmR/JRQOkRSn+YOrLWbnzN3BCEYMBxQZXZh2
         DAnGEzMBIDk2ung1IxeqxLOryV0vj9eIUbPlcOFJ4dnW6yGMVUMeLvPo4kL00NLR+b
         ak6bdNn3NffsEbOVSJajQrjNHMXDLUHq5jGacGss=
Date:   Sun, 11 Apr 2021 10:39:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v3 3/4] staging: rtl8723bs: Change the
 type and use of a variable
Message-ID: <YHK1sS6N/+dcxxhZ@kroah.com>
References: <20210411082908.31876-1-fmdefrancesco@gmail.com>
 <20210411082908.31876-4-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411082908.31876-4-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 10:29:07AM +0200, Fabio M. De Francesco wrote:
> Change the type of fw_current_in_ps_mode from u8 to bool, because
> it is used everywhere as a bool and, accordingly, it should be
> declared as a bool. Shorten the controlling expression of an 
> 'if' statement.

The "shorten" portion should be in patch 4/4 as it does the same thing
there, right?

Don't mix the two here, the changing of the type is fine to do alone as
a single patch and the if () change has nothing to do with that.

Also, you have trailing whitespace in your changelog text :(

thanks,

greg k-h
