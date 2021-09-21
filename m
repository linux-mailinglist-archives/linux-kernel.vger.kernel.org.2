Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9D841342E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhIUNdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233194AbhIUNcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:32:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57D5C61131;
        Tue, 21 Sep 2021 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632231086;
        bh=AQyv/1AdlbzlavJ6+tcE4QNlo2I2ItzP6gTJvvrDye0=;
        h=From:To:Cc:Subject:Date:From;
        b=S7NW+cSofPbzSC97YtegSeOlHc8rWYge4hP59UC36YXWpsaEIqxbsEGcvgG7wyry2
         wuPHqDpDJUHa/8aUaLI+W2EZxuoOzkWoGZN5tLiovMrsIjzZOpAIClMcPJa1WIlEJ8
         h7iXv/F2QZ5HmAHJGfk1ZCzSzguwz0fWInOF4tjDz3KiEwpQKSENPP8lam2V8xjWJj
         1Mu89GT0TsCQxuVUQgLVlw3MhKB7CJrkJ9UuAak8iSytx6FIjAEcWxZl0nD26IId2q
         gUf/vZ0K6TgBhPsjlwmzTkco59J8qaKoPCdwlXiwrYuaNEYx2OibBEizkwGINeyYWS
         qAGBy79rEwmdQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSfro-0003bL-GG; Tue, 21 Sep 2021 15:31:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Himadri Pandya <himadrispandya@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] USB: serial: kl5kusb105: clean up line-status handling
Date:   Tue, 21 Sep 2021 15:30:06 +0200
Message-Id: <20210921133009.13739-1-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a follow up to the usb_control_msg_recv() conversion, this cleans up
the line-status handling some more.

Johan


Johan Hovold (3):
  USB: serial: kl5kusb105: clean up line-status handling
  USB: serial: kl5kusb105: simplify line-status handling
  USB: serial: kl5kusb105: drop line-status helper

 drivers/usb/serial/kl5kusb105.c | 40 ++++++++++-----------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

-- 
2.32.0

