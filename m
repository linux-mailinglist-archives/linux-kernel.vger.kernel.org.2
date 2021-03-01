Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7060E328E68
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241931AbhCAT3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 14:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236183AbhCAQxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:53:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2280564F2D;
        Mon,  1 Mar 2021 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614616452;
        bh=zsJLBzVCRHREkfNwSrGlTpep6kVC51aCL/mSW45vNiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Cf06taKQfH/QCSf8aM3gVrjl9w647t+Z4kFHERBjVmnxZOBPuTO2+jbb+ykoKWvs
         m1CyrvE7ZmVs8VT7PlSbStmhpWPuL5JncVQhM1Gz8U1/q6VkfScq68ob1L4Q1HPVSr
         9hS9by+95zOns3qtaYN0IRrg81BrwQRyxxumusNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tho Vu <tho.vu.wh@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 155/176] usb: renesas_usbhs: Clear pipe running flag in usbhs_pkt_pop()
Date:   Mon,  1 Mar 2021 17:13:48 +0100
Message-Id: <20210301161028.714397990@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161020.931630716@linuxfoundation.org>
References: <20210301161020.931630716@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 9917f0e3cdba7b9f1a23f70e3f70b1a106be54a8 upstream

Should clear the pipe running flag in usbhs_pkt_pop(). Otherwise,
we cannot use this pipe after dequeue was called while the pipe was
running.

Fixes: 8355b2b3082d ("usb: renesas_usbhs: fix the behavior of some usbhs_pkt_handle")
Reported-by: Tho Vu <tho.vu.wh@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/1612183640-8898-1-git-send-email-yoshihiro.shimoda.uh@renesas.com
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[sudip: adjust context]
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/renesas_usbhs/fifo.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -137,6 +137,8 @@ struct usbhs_pkt *usbhs_pkt_pop(struct u
 			usbhsf_dma_unmap(pkt);
 		}
 
+		usbhs_pipe_running(pipe, 0);
+
 		__usbhsf_pkt_del(pkt);
 	}
 


