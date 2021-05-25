Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE77439027B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhEYN3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233472AbhEYN3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:29:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D46F6142E;
        Tue, 25 May 2021 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621949253;
        bh=G5T3FBq3c73v2BlrVGNRz2ClgCthrJuqOvTanh2Lelw=;
        h=From:To:Cc:Subject:Date:From;
        b=UC8hD31L22/MsAdLn9dCgs7knTkd0MUzxxa8aPjAfNS/wVFzBzMX8r67q55h5l91p
         yPTdXhlhXaKy9DwniY8Bma5mOl79deB56oPaCkDjcrvuuxIx3aKMEaiGbNFU2f4h7M
         L6wTvuMDFgHa4jvNA+f7zJ6W64SGL5DsQevDrBbtUGyiK5iHSRt5PEtZcP6VcWfFS6
         cEk4npbjo/iw4HyDPEnifsuvQqKLXfZ/vFqPZW3dHO5icGnb3N1IMh/DjQHuhAfCE1
         VjUF5QNaEtQUX10EJl6x7zqzwR5mg52/F1BkQhBp8pXFE/H26LjJKBDHKRUpz71NUE
         w0J3WkuxhGsmw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1llX5m-000uZi-Dd; Tue, 25 May 2021 15:27:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 0/2] Fix some issues at scripts/sphinx-pre-install
Date:   Tue, 25 May 2021 15:27:26 +0200
Message-Id: <cover.1621949137.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when using with --no-virtualenv, the script doesn't behave well,
as it prints both instructions to install Sphinx via distribution's package
manager and via pip.

Address it.

While here, rework the logic which recommends Sphinx install, by
splitting it into three parts and making easier to maintain it, as
there are too much complexity there. Splitting the Sphinx part
of the logic on 3 separate functions allow to detect if the venv/virtualenv
python packages are needed or not, and helps to have a cleaner
logic.

Mauro Carvalho Chehab (2):
  scripts: sphinx-pre-install: rework the sphinx install logic
  scripts: sphinx-pre-install: fix the need of virtenv packages

 scripts/sphinx-pre-install | 262 +++++++++++++++++++++++++------------
 1 file changed, 180 insertions(+), 82 deletions(-)

-- 
2.31.1


