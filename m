Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05465329C51
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 12:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380506AbhCBBxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 20:53:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241865AbhCAT3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:29:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E3A165313;
        Mon,  1 Mar 2021 17:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614620586;
        bh=+77gvzJD6GpuIUbEosPv9Y2DCi53ioJdAVnH6gciq0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPaOz9BOD/Rlt5zxyhPgzjuTYzp//6/kwrMKDUtqLH60NDig3Pr39fcqh+NmuoYIs
         m1QpJhfpgygw0CsRq1IfMCr83QvYamy47XpcTtBjJSqBMcS9j1pycEbjsXsFjLU7cj
         hE3d/LDWcs5jyNO0V23thRwc/oJ9WqtsLU50pOYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Robert Foss <robert.foss@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.11 199/775] media: camss: missing error code in msm_video_register()
Date:   Mon,  1 Mar 2021 17:06:07 +0100
Message-Id: <20210301161211.477673041@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161201.679371205@linuxfoundation.org>
References: <20210301161201.679371205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 9c67ed2ab299123872be14a3dc2ea44ce7e4538b ]

This error path returns success but it should return -EINVAL.

Fixes: cba3819d1e93 ("media: camss: Format configuration per hardware version")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss-video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index 2fa3214775d58..97cea7c4d7697 100644
--- a/drivers/media/platform/qcom/camss/camss-video.c
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -961,6 +961,7 @@ int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
 			video->nformats = ARRAY_SIZE(formats_rdi_8x96);
 		}
 	} else {
+		ret = -EINVAL;
 		goto error_video_register;
 	}
 
-- 
2.27.0



