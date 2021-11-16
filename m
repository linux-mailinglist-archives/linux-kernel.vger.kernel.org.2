Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F14531F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 13:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbhKPMTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 07:19:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233068AbhKPMTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 07:19:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49EA461B44;
        Tue, 16 Nov 2021 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637064987;
        bh=Zb7Sns/nkl+cmZXiJb1Jl1QoMKldzzzAeh2SCbE4G2U=;
        h=From:To:Cc:Subject:Date:From;
        b=aZ+OwftS6YPHEAHvamTaWYtsFfHjKgMrAKGXhFiJK1Vzm7CtGGcCBMIyd1aiR5794
         1Cwtz/RBGxGuHK4BO0R4Gjb+7j3uw/6DX1jBuBITKCwQM2PUgMswHOzsPhXIg3fJxI
         /EEaHS9dwfBgdGZ1ZXw181bhedBKiBKO+FDD4Sbr9loSElD9LW3hQJIxkceIpdHqb8
         40iCJG1o0apgX5QNebfXJ29wzFfATflxvlTMu32C1ByGiMXeoUwkc2L9YuFcAJUc3E
         suAiR7XN+k9uQtziIACFVnyHYX0saWKw+iUZgf1UQjLdW8O+gMP+B7/6XwlzH1zdf4
         Wtxb1v1WBloGQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mmxNw-00A9Pr-Ox; Tue, 16 Nov 2021 12:16:24 +0000
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        sparmaintainer@unisys.com
Subject: [PATCH v3 RESEND 0/1] Fix a badly encoded copyright symbol
Date:   Tue, 16 Nov 2021 12:16:22 +0000
Message-Id: <cover.1637064818.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I sent already this patch a couple of times to the maintainer, but got no
answer. So, maybe the maintainer just become unresponsible.

As this is really a trivial patch, if you won't mind could, maybe the best would
be to have this merged via your tree.

Thanks!
Mauro


Mauro Carvalho Chehab (1):
  visorbus: fix a copyright symbol that was bad encoded

 drivers/visorbus/visorbus_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.33.1


