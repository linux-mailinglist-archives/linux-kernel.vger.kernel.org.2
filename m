Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C51D3A04B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbhFHT50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234524AbhFHT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/+OD7OvS+76UUwXsW39r3R0qwsEt76jbnvntpEkAgY=;
        b=fvWULo9U34E9ALDSFekk1wc4rqdRJ+Q8l6h5zQb+YdT9OCdLGMM+eX9dv0sZg/OsLGj8/v
        qA+Q47TSE42T++LvfsNjlek5YIOoL6KKOeSI2VN35Q0hqpY4BAKMRw8lB1mEVDXQXJtk/z
        9MKbwCTDlaLqkPU8dmeFxXBMUebTjBQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-zbAzcXSMMQe6Qe3RwBekbw-1; Tue, 08 Jun 2021 15:55:13 -0400
X-MC-Unique: zbAzcXSMMQe6Qe3RwBekbw-1
Received: by mail-ot1-f69.google.com with SMTP id b3-20020a0568303103b02903ed1990d4c1so4819076ots.16
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/+OD7OvS+76UUwXsW39r3R0qwsEt76jbnvntpEkAgY=;
        b=SbP4czS1OxvZ9SIW1jNds+Ds0YeeyyeipL9ut1YaHck6WtfBtRkW3nYHVkaIuDPBJS
         IyK2EyBfa7oAyAzox1AjUBQiDm39o1JRBnS7UxEFF8WqTcggwsw7AjtVbNbuv6YV9/EP
         14bRSRfXTLVzxnHwIv2uwOMXJkhsh1kDN/xwz1Aq0uJvRMGjLybohpvi/Knv1l48ZYpQ
         CAiEQYpw2SS4w8RmgXU6wQ/DOkWUQlCiPpnSlAmMLFJLdS/mnE8N5grOuz6WEuD4knAg
         TEoZ816gTmDBsMEdNVbDb3UbUsDU4ZGqtdw4C57Lk1w894Ub7kO8xNCh4k3GlgpkxEEI
         lH2g==
X-Gm-Message-State: AOAM532CO40HOCWAl32uii/3hBQmmTaplilM6sSjNEvLoGJvdvdpkxc9
        qcEWUwmT0s/XzdWLzk/+UfKkxNRcL/oJBIBhYnQClgvt5Xs6sDTZbb4Mttplz1raoq92cOQS7Fz
        Twiabjxu//YvhzuJJOcgTjkKP
X-Received: by 2002:aca:5b8b:: with SMTP id p133mr3992482oib.75.1623182112431;
        Tue, 08 Jun 2021 12:55:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbDl4SpSap74DUV7pafZUncOFUOrU/Cz2F9tkGN+Hxjt6lNnqX1mltU/vlxo0GVifoqg5pNA==
X-Received: by 2002:aca:5b8b:: with SMTP id p133mr3992474oib.75.1623182112286;
        Tue, 08 Jun 2021 12:55:12 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:12 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/7]  wrappers for fpga_manager_ops
Date:   Tue,  8 Jun 2021 12:54:59 -0700
Message-Id: <20210608195506.3022550-2-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608195506.3022550-1-trix@redhat.com>
References: <20210608195506.3022550-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

As followup from
https://lore.kernel.org/linux-fpga/06301910-10a1-0e62-45a0-d28ab5a787ed@redhat.com/

Boards should not be required to have noop functions.
So improve or create fpga-mgr wrappers for the fpga_manager_ops.  
Remove the noop functions.
Refactor fpga-mgr to use the wrappers.

write_sg op was not wrapped on purpose.  Its checking / use in
fpga_mgr_buf_load_sg() did not warrant a wrapper.

Changes from

v1: commit subject,log

Tom Rix (7):
  fpga-mgr: wrap the write_init() op
  fpga-mgr: make write_complete() op optional
  fpga-mgr: wrap the write() op
  fpga-mgr: wrap the status() op
  fpga-mgr: wrap the state() op
  fpga-mgr: wrap the fpga_remove() op
  fpga-mgr: collect wrappers and change to inline

 drivers/fpga/dfl-fme-mgr.c   |   6 ---
 drivers/fpga/fpga-mgr.c      | 102 +++++++++++++++++++++++------------
 drivers/fpga/stratix10-soc.c |   6 ---
 drivers/fpga/ts73xx-fpga.c   |   6 ---
 drivers/fpga/zynqmp-fpga.c   |   7 ---
 5 files changed, 67 insertions(+), 60 deletions(-)

-- 
2.26.3

