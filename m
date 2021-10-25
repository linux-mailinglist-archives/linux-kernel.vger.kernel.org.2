Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00C643954E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhJYLyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhJYLyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:54:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFFC360F22;
        Mon, 25 Oct 2021 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635162744;
        bh=64JTkQdfnCEcyTbOrpuw5TUx7qN2aLjfP/gHT58Jkos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ps1Uxoqs+29aiUqd263s05TbWkrU8YhrG37j4mqkxiqAkGMltNo+/bBxM+laY4ZeU
         Cg0S+EF7lnc7svOuOe9ckLlioJ6DE30ojgpTGrpQuBIDWnMwBaUvyBY8R3vdjt9spO
         kjuaEE4o2gRIs2F/SzPD8XUZAz2F8pb/xfTOD9XwtlxIpFHEiFjrf0NtaFG4aSW3/L
         kL57GHDq3+qfPqxmHWPRSp9ldL0K9TJnYtSezENQWF0E8UDzvnlvpSSwQXMp1vMVRR
         IDz32tNp3QHbO3OUK3gNzbxeV01iCgFnT98rBzfiZcAasTy7Nh/akH/JqiVVD/bdbN
         fNft2uTdBMqbA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1meyWN-0001Im-Oo; Mon, 25 Oct 2021 13:52:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] Documentation: USB: fix example bulk-message timeout
Date:   Mon, 25 Oct 2021 13:51:58 +0200
Message-Id: <20211025115159.4954-2-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025115159.4954-1-johan@kernel.org>
References: <20211025115159.4954-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB bulk-message timeouts are specified in milliseconds and should
specifically not vary with CONFIG_HZ.

Use a fixed five-second timeout in the "Writing USB Device Drivers"
example.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 Documentation/driver-api/usb/writing_usb_driver.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 2176297e5765..4356f023065b 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -231,7 +231,7 @@ error message. This can be shown with the following code::
 			   skel->bulk_in_endpointAddr),
 			   skel->bulk_in_buffer,
 			   skel->bulk_in_size,
-			   &count, HZ*10);
+			   &count, 5000);
     /* if the read was successful, copy the data to user space */
     if (!retval) {
 	    if (copy_to_user (buffer, skel->bulk_in_buffer, count))
-- 
2.32.0

