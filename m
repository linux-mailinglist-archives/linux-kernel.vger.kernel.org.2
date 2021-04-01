Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8238535129A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhDAJoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhDAJnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:43:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9CCC061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:43:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so571973wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MvDTzgNqLtGrTzo9lbjHv2I7gMQ+wi7KdCMzVMfFsg0=;
        b=VLL/l3u/gAJp+HDLEc6JK9z5pVYpS2bHMLgMaCbxqIB73jZ0/jXnWRxgsHJ545IKFt
         EKwA/TLcRuoMZLrxCH1bBHp3joTfWZZR9TdhJOXPY9lYTDqkdCoWW/9r/Skd8Qs2jITz
         b30HcrJWkuqurVB/+ulEXpbeIO0ROOuADCMXQVMJkVbxDH7Bn8MS9NoDdcQjQ/kNfgdd
         imqYUrsN3a664xhSr58LKaPnOWhTphuOJXOPVOPVqZF2hgCLXrvIuCoanXmb1nUH3Jwt
         Dwv7dA4KAYVsBmlbLU7Q/niqV7BPkXljoXObtmXTsUHHj9JOm+jgiFm2alrWc38mCYoA
         +OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MvDTzgNqLtGrTzo9lbjHv2I7gMQ+wi7KdCMzVMfFsg0=;
        b=uGgsxBRsN4sdEmQ1H3V1WUJQil3stN/hX5LG3K9sBC/pE1kGBLi0/Yss5XX3vqth8R
         TwLmM4QmclG5N2qag/Y1w6eCetCiAei881bm/AkTeWwe1oYqJmVgPF+Fw7z4BVxM61/l
         Nv0m4gR5/0qw+woiwfJmRW5X7q5X+5cNFag1zRaEAJAKWs3RzROX1fKwNxGnfjWycHpJ
         gW7Nv/7PFJemEMpKVOpdJ0+nxej6oMpiqEJTVz3cqDB2hcNe5+HPrErVljvj2vlRGv96
         on7yBZoORs08myiCrqr5Ce0Ep3GGm3Jwo4199fcZrohv5zdeOfyeg/uET8HnB1hT2hqg
         8sbw==
X-Gm-Message-State: AOAM531b4UzGyaCacJblJW45P2v3ev0Wx0/PEk7Rqv5PuyQhpTH3aqK6
        vZ0m61QIr7cd5ZGq7AFIJ+ziSQ==
X-Google-Smtp-Source: ABdhPJxIB1GJQXZLUIjidsLydJHJeRJrZN6krpBUwIl3xJEWDOMpiNx94TO9OqUmh3sw2EL/NzHm+Q==
X-Received: by 2002:a1c:7516:: with SMTP id o22mr7072994wmc.91.1617270217383;
        Thu, 01 Apr 2021 02:43:37 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a131sm7747871wmc.48.2021.04.01.02.43.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:43:36 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     djakov@kernel.org, vkoul@kernel.org, elder@linaro.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH] interconnect: qcom: sm8350: Use the correct ids
Date:   Thu,  1 Apr 2021 12:43:34 +0300
Message-Id: <20210401094334.28871-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For creating an array with the members for each NoC, we should be using
a local indexes, as otherwise unnecessary large arrays would be created.
Using an incorrect indexes will also result error for the consumers when
they try to find a valid path between the endpoints. Let's fix this and
use the correct ids.

Reported-by: Alex Elder <elder@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sm8350.c | 80 +++++++++++++++---------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index f3aab02b8678..01202989a5b2 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -228,20 +228,20 @@ static struct qcom_icc_bcm *aggre2_noc_bcms[] = {
 };
 
 static struct qcom_icc_node *aggre2_noc_nodes[] = {
-	[SM8350_MASTER_QDSS_BAM] = &qhm_qdss_bam,
-	[SM8350_MASTER_QUP_0] = &qhm_qup0,
-	[SM8350_MASTER_QUP_2] = &qhm_qup2,
-	[SM8350_MASTER_A2NOC_CFG] = &qnm_a2noc_cfg,
-	[SM8350_MASTER_CRYPTO] = &qxm_crypto,
-	[SM8350_MASTER_IPA] = &qxm_ipa,
-	[SM8350_MASTER_PCIE_0] = &xm_pcie3_0,
-	[SM8350_MASTER_PCIE_1] = &xm_pcie3_1,
-	[SM8350_MASTER_QDSS_ETR] = &xm_qdss_etr,
-	[SM8350_MASTER_SDCC_2] = &xm_sdc2,
-	[SM8350_MASTER_UFS_CARD] = &xm_ufs_card,
-	[SM8350_SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
-	[SM8350_SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
-	[SM8350_SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
+	[MASTER_QDSS_BAM] = &qhm_qdss_bam,
+	[MASTER_QUP_0] = &qhm_qup0,
+	[MASTER_QUP_2] = &qhm_qup2,
+	[MASTER_A2NOC_CFG] = &qnm_a2noc_cfg,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_PCIE_0] = &xm_pcie3_0,
+	[MASTER_PCIE_1] = &xm_pcie3_1,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[MASTER_UFS_CARD] = &xm_ufs_card,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
+	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
 };
 
 static struct qcom_icc_desc sm8350_aggre2_noc = {
@@ -414,10 +414,10 @@ static struct qcom_icc_bcm *mc_virt_bcms[] = {
 };
 
 static struct qcom_icc_node *mc_virt_nodes[] = {
-	[SM8350_MASTER_LLCC] = &llcc_mc,
-	[SM8350_SLAVE_EBI1] = &ebi,
-	[SM8350_MASTER_LLCC_DISP] = &llcc_mc_disp,
-	[SM8350_SLAVE_EBI1_DISP] = &ebi_disp,
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+	[MASTER_LLCC_DISP] = &llcc_mc_disp,
+	[SLAVE_EBI1_DISP] = &ebi_disp,
 };
 
 static struct qcom_icc_desc sm8350_mc_virt = {
@@ -439,24 +439,24 @@ static struct qcom_icc_bcm *mmss_noc_bcms[] = {
 };
 
 static struct qcom_icc_node *mmss_noc_nodes[] = {
-	[SM8350_MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
-	[SM8350_MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
-	[SM8350_MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
-	[SM8350_MASTER_CNOC_MNOC_CFG] = &qnm_mnoc_cfg,
-	[SM8350_MASTER_VIDEO_P0] = &qnm_video0,
-	[SM8350_MASTER_VIDEO_P1] = &qnm_video1,
-	[SM8350_MASTER_VIDEO_PROC] = &qnm_video_cvp,
-	[SM8350_MASTER_MDP0] = &qxm_mdp0,
-	[SM8350_MASTER_MDP1] = &qxm_mdp1,
-	[SM8350_MASTER_ROTATOR] = &qxm_rot,
-	[SM8350_SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
-	[SM8350_SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
-	[SM8350_SLAVE_SERVICE_MNOC] = &srvc_mnoc,
-	[SM8350_MASTER_MDP0_DISP] = &qxm_mdp0_disp,
-	[SM8350_MASTER_MDP1_DISP] = &qxm_mdp1_disp,
-	[SM8350_MASTER_ROTATOR_DISP] = &qxm_rot_disp,
-	[SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP] = &qns_mem_noc_hf_disp,
-	[SM8350_SLAVE_MNOC_SF_MEM_NOC_DISP] = &qns_mem_noc_sf_disp,
+	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
+	[MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
+	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
+	[MASTER_CNOC_MNOC_CFG] = &qnm_mnoc_cfg,
+	[MASTER_VIDEO_P0] = &qnm_video0,
+	[MASTER_VIDEO_P1] = &qnm_video1,
+	[MASTER_VIDEO_PROC] = &qnm_video_cvp,
+	[MASTER_MDP0] = &qxm_mdp0,
+	[MASTER_MDP1] = &qxm_mdp1,
+	[MASTER_ROTATOR] = &qxm_rot,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC] = &srvc_mnoc,
+	[MASTER_MDP0_DISP] = &qxm_mdp0_disp,
+	[MASTER_MDP1_DISP] = &qxm_mdp1_disp,
+	[MASTER_ROTATOR_DISP] = &qxm_rot_disp,
+	[SLAVE_MNOC_HF_MEM_NOC_DISP] = &qns_mem_noc_hf_disp,
+	[SLAVE_MNOC_SF_MEM_NOC_DISP] = &qns_mem_noc_sf_disp,
 };
 
 static struct qcom_icc_desc sm8350_mmss_noc = {
@@ -472,10 +472,10 @@ static struct qcom_icc_bcm *nsp_noc_bcms[] = {
 };
 
 static struct qcom_icc_node *nsp_noc_nodes[] = {
-	[SM8350_MASTER_CDSP_NOC_CFG] = &qhm_nsp_noc_config,
-	[SM8350_MASTER_CDSP_PROC] = &qxm_nsp,
-	[SM8350_SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
-	[SM8350_SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
+	[MASTER_CDSP_NOC_CFG] = &qhm_nsp_noc_config,
+	[MASTER_CDSP_PROC] = &qxm_nsp,
+	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
+	[SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
 };
 
 static struct qcom_icc_desc sm8350_compute_noc = {
