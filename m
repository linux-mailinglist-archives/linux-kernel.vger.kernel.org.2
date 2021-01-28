Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E682D307CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhA1Rf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:35:56 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41247 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhA1Re5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:34:57 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1l5B9C-0006Sz-Uk; Thu, 28 Jan 2021 18:31:59 +0100
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@pengutronix.de,
        jlu@pengutronix.de
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Migration to trusted keys: sealing user-provided key?
Message-ID: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
Date:   Thu, 28 Jan 2021 18:31:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been looking into how a migration to using trusted/encrypted keys
would look like (particularly with dm-crypt).

Currently, it seems the the only way is to re-encrypt the partitions
because trusted/encrypted keys always generate their payloads from
RNG.

If instead there was a key command to initialize a new trusted/encrypted
key with a user provided value, users could use whatever mechanism they
used beforehand to get a plaintext key and use that to initialize a new
trusted/encrypted key. From there on, the key will be like any other
trusted/encrypted key and not be disclosed again to userspace.

What are your thoughts on this? Would an API like

  keyctl add trusted dmcrypt-key 'set <content>' # user-supplied content

be acceptable?

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
