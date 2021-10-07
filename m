Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA649424D57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 08:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbhJGGjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 02:39:09 -0400
Received: from sonic317-22.consmr.mail.gq1.yahoo.com ([98.137.66.148]:37002
        "EHLO sonic317-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230491AbhJGGjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 02:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1633588632; bh=lSPFEV4jButoTElTw5/K8Lz6m5y9sdQDE0xu+Hd4ZCE=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=eqRCPu9UsCXvr/h44H70ZAywcgenDodPNCy46wFsGaosBO39OyXHiD/7W7rpsqyasJAWUO3Saq9EUuXQ0Ns2j3FFX14vsE11CdNNAW6aHa0vwQQv7DZHzHlM+oK2N1mcnYmrCz38U6G3OcbbUHHAUgolBcJotq0CfBKZpwHSIKcpOEm4K+uPfdI2xXiRwqFLm8xE3TE/CFFba0hHZaMWln3+do5DbpZjaKNCPHSkr3BhcDU6Cu2+48NvmVlOkIjXeHPoOKdbRil9piDMpHALLo/DhmTdeapeGbg72dRNnbk+vTim5pLTk17eaFLFThhhnturAQeFLxscRz7ea/sDkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1633588632; bh=X9b5tbG0XK0qKfb8I7T1xiU+zpLFi9FEtJGotYy17NM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=s3eSZqeeQVURyTiRHTSCxNSV4uS3bu0V6P4C6l1Cp7RCTSrPso4sYO7z4K2/1Dcb6xLHYmUJF1PZTAPbLR6FehM1yTXriCTnmZqwci69nsLEATXiRUSR1dpUvzP1g2TLquuW6iBjDNq3xuNr//v+JhsW567BLXelNi5QCPxDpG77SE5nd4g1blOqtw/D2H/Zp5hBPxyczUttcsBhp8hbxT1LnaPWooIMwUwEcePBLlItfps89+0FSE2SGowHHnq9Xaje4M+fmliKNLUKAsX/woTabg0wSvxldtToY3oH59jWMJAWNu75MbQXJ+w5IODOeEze+wmBsBn3rMRvUIbYyQ==
X-YMail-OSG: X3Z6AKwVM1kHEaBDKjVnfyogvy2ujoQSWmwy1zvVQ92VWhAxZtGZmPwVGcVg0bf
 GBufUnRrH_yJ7j9ffSzZHJlRfR_q0ThvCOghYhf.CoBqStQwLdAmL79zoBwFHLyGVf4e2VDzufw8
 Zv_mXT6RXGj_baSztJD9d2ikL3ONJz4GxlKvWPewWkCyzogqUgijzXmKS.VusOgt5LyzwnWeJMBi
 g8MQShGJVSDB8TuD6FwslynHSM7vALRYOk2Oez4KDa7GZkpr9RU_lPosJUDbvXR7W3CCHXOqcuae
 epFcfYDD0Y4R0MB71daFbASRCWBabC3qGq5F.FXG2oNFfiZEhMtC.H1Xl.Mauxt52A.Hu1t.SqB_
 i50Pbh3F_sUcTj406yGH4tAStHIF97hp0buFo1Vwhu.sbR7tCP0mWyBncEvoW7V6ne5hY2nrionm
 qZrZHWiSQ3nR_73qj2HQso05aODvBTMyIEz8ELKUwb9lUjGQQT6TIh5_REIyx45PyKmH_wITFXlr
 il0Fmgj2kgkNr8gdnHHyqf39IwMuqddsSoW6mKMS6WLZLMqjMJnXB07EovKvdwKIfXwWSJHGnPIu
 lwMJJmZGQR.3c9ylteL1Ii5AUWptbKKPNGA_N455wrEi3kmSyK1cl9Qv5GtWisCJ9jd067cLXMoA
 BsquNCzLeLbUUvMzRiKcf8XFX3HLGAYYGh1yUJkUpgX0D7T3QvSbA0ZGpMDU2b6g4zZwX_uIb5Q9
 OY8Jx7FaP0hCMGWC3UQlN3mIR5J8h1bv4hCMK3bWwugXBavKJTwnta2q_NttNnh6hZn3npOF3_gV
 PE0N.lQfko9xLWQCV09To_FU_cRfvliEyW9N6mxDOzqyil.Q3XC8662i1pnNH5rbSZ9Jo8T67Yz6
 FBWgDyjzgyuYee8rOjubkJnJ3kIXiNxBYe8Y6FoCI.VB.ck3Vm6MStxkgdaLYlsDOeuoDzTQEXcz
 i0ux8iNOj_8_59P8gJq0isocY82hGWtcI_i1290.hyowPb_LNPCBPRQfv2LL1QyOt4YkI2qZNolJ
 Cd1u7II_pwdYIMGcaYgdOWysjigy8Nxx3VqjepPLmpOyyxN1vK6S1ZqPNROW8zBQJL6__4nggRrw
 1tYflm_KVDCFMFZpQfvXgV7q4QD0OKQlOJQSrGHBh92ydXynU.Izjx4cbfN2GIgSjhzdEuif8yaz
 I3HBDRKWsArvooEsM65r6oYr7XBMDVtCN28BqUwBdgi6nMGaQNNzPn56s.Xa_jszfdD4gXYocD25
 RhX0yBCKgn2tj3hvF9NKG8H1DAQwg0yWFKW5r8ZtzalQi_qcJ7oe3sJzwWsWOIjIIM8W9ruRGVl5
 vFkzFobOtQTEf.QkqAhqKZo1svyMTbd2_QHXe7828zvOL89QItOqhkDZb.Wums.bHrChebrP6cmS
 n6bybiwmXrfb1DMiqgmCI2e9EYW_7j_ujlblWY3EWTabnX6OkzmG3aTdc3HVYuTZpVDa_OKvvrhO
 1TE1c8uVTUmk1CgIz4lJyc3h4_5qG4yByvDMroGo5mWw4Mt5GdotCqTr5kNhQ6ZHhjTP10RG6Xlq
 HqgJP8_xJCe_HzjvtAlwS35K070zAkk35E_BBNvXiKqvLbvP6ygW1_tadHyYxE5ttOsvsuCp0d8d
 evNuEVzpuf2DRC8h3BndjXgIWLZBNYUqxUy2w_2K1Mw32qmmrv5HFVsnnSa7MmE6Uysiqba1uWEW
 dxcrh18xqUfb_sDQd5rZZ3olqj12GqNd31dAiId3YEBN5LZwxwZqx5nWX9buGZ6uk9Y0EtpHw_YX
 rBIxQNF.vB9qm6TRi1ebsKJH5nnB08K3lrng4DD1iheqw5ujn7h93RComTYwkrYCvTkyiPJnKBAf
 s8PajFYh60hUMr27uykg_e.8Mt3BbOyBweKfiIXLgL0R0YVTWYEETfY9yWtPfN5sgb6Le.ApBDMr
 1RSHbHhKYB_jAHkMwsEqsgZV3rOdbvGk05iTj5Fg0qIFuqLEDM218.oWEQNKOfUCuTUhBNGRahht
 EAZtQpQA9PBxf5YixbwgiYoQvaldj6dDyBFcRUNlEklLrQy_AQgx1qo_53vJp2plSGgHZzssJSFt
 uJEiv9cqZAr0ito8S7R72i3MqCjWEeWNfcpYS.Is5ALuSiewq_Zi8iiXtFI9jfOPIGVh0W6ckWuP
 B_9D9kIH0dxuhq7v3fcPddBK.KWS3FxGdKmzT6QJ15wuVqt7KVSKOOF5v3lpsX4MvdsdPnWJ8FN7
 ypMKJFaBbZdzv0FSOhg1o5y8e5QlPLK5PJQXiPHJdlZguhHIm6S3rZEOcWkbBB4IG1b9WxS.SKNG
 7U3UmagTJLlwN82RkUCwsQHZHdPf5mmexNN9q6kjieF09E_NPdTzC0ASikA--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Thu, 7 Oct 2021 06:37:12 +0000
Received: by kubenode520.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fd4e705cbc19264f98ad12010b56fdd1;
          Thu, 07 Oct 2021 06:37:08 +0000 (UTC)
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
To:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Cc:     ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org,
        Simon Ser <contact@emersion.fr>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH v3] drm/plane-helper: fix uninitialized variable reference
Date:   Thu,  7 Oct 2021 02:37:06 -0400
Message-Id: <20211007063706.305984-1-alex_y_xu@yahoo.ca>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20211007063706.305984-1-alex_y_xu.ref@yahoo.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/drm_plane_helper.c: In function 'drm_primary_helper_update':
drivers/gpu/drm/drm_plane_helper.c:113:32: error: 'visible' is used uninitialized [-Werror=uninitialized]
  113 |         struct drm_plane_state plane_state = {
      |                                ^~~~~~~~~~~
drivers/gpu/drm/drm_plane_helper.c:178:14: note: 'visible' was declared here
  178 |         bool visible;
      |              ^~~~~~~
cc1: all warnings being treated as errors

visible is an output, not an input. in practice this use might turn out
OK but it's still UB.

Fixes: df86af9133 ("drm/plane-helper: Add drm_plane_helper_check_state()")
Reviewed-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---
 drivers/gpu/drm/drm_plane_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_plane_helper.c b/drivers/gpu/drm/drm_plane_helper.c
index 5b2d0ca03705..838b32b70bce 100644
--- a/drivers/gpu/drm/drm_plane_helper.c
+++ b/drivers/gpu/drm/drm_plane_helper.c
@@ -123,7 +123,6 @@ static int drm_plane_helper_check_update(struct drm_plane *plane,
 		.crtc_w = drm_rect_width(dst),
 		.crtc_h = drm_rect_height(dst),
 		.rotation = rotation,
-		.visible = *visible,
 	};
 	struct drm_crtc_state crtc_state = {
 		.crtc = crtc,
-- 
2.33.0

