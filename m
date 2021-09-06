Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79FC401F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244141AbhIFRnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:43:40 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.106]:18515 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243962AbhIFRnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:43:39 -0400
Received: from [87.92.210.171] (helo=lumip-notebook.fritz.box)
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <lumip@lumip.de>)
        id 1mNIcL-0002Yk-9g; Mon, 06 Sep 2021 19:41:13 +0200
From:   Lukas Prediger <lumip@lumip.de>
To:     axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/cdrom: improved ioctl for media change detection
Date:   Mon,  6 Sep 2021 19:53:17 +0300
Message-Id: <20210906165316.86857-1-lumip@lumip.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2f78b2f4-e290-fb58-c097-0f2fdf781f02@kernel.dk>
References: <2f78b2f4-e290-fb58-c097-0f2fdf781f02@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: bHVrYXMucHJlZGlnZXJAbHVtaXAuZGU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jens,

not sure if it has escaped your notice since I didn't put
it as a reply to this message, but I have submitted an
updated version of the patch a few days ago:
https://lore.kernel.org/lkml/20210829143735.512146-1-lumip@lumip.de/

Best regards,
Lukas
