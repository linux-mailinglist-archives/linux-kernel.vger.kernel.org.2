Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13143C3E50
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhGKR1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 13:27:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:60537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230353AbhGKR1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626024293;
        bh=AnCY0pjNVPxfMlK/RMJloKhD8Gf9lUzrKmoISOVbvLE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lB+tdjK9F5mr7KbWU43j91pvP4kG8HHIeFXJfFX9OFpzesLHLy82JVTU9Br221rlw
         36OSTOcyJxsudtd/aVIHznaa53epieu38pVnCpdTTfVRzcD3UdgVEk24/GqJ2s/JjX
         d4lWs+kOpCo+xOgi30C0/Aj93EWAflGymBh0/hvE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MUGe1-1lbRWo0pRD-00RIK7; Sun, 11 Jul 2021 19:24:53 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Len Baker <len.baker@gmx.com>, Wenjing Liu <wenjing.liu@amd.com>,
        Martin Tsai <martin.tsai@amd.com>,
        Kees Cook <keescook@chromium.org>,
        George Shen <George.Shen@amd.com>,
        Yu-ting Shen <Yu-ting.Shen@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix identical code for different branches
Date:   Sun, 11 Jul 2021 19:24:33 +0200
Message-Id: <20210711172433.2777-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y3gzwZrH3SZG80PK9ruDRlopijLNaqyUfz3yCTcTZ7jUMp6kn+f
 Tx5otUZe2s3OfMm9+BPkH8unLbEPc1a0/kZhoUaW1YOK9gmNKBKJCwvmzXP6leaVdpatS8U
 B1iXIqAzC8kSVw2eSqWvCGxztVaLL3RG3KB72Mt1bGw91fWJsF7kByjyIwuIHITd1MHps79
 uD4CRPByosFd4JbGAY7nA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0T9ZeVYgxY4=:YLkjJGazRzNGjutU36UaUz
 5730Dr5vyRWA3EMPbahBhqYOnyGyKnagYVBswS2ON0rpEWb1IX8Q+K5Q8QhmcKPxSKP0jZKek
 xZazM6kYa1YObHOmrFpHuXsbB7rm/tuTgLE5yN7g0gfTp/x7sm5S/eJ4WjKmqrOtbdwISJyis
 uUjoKeVyveinL7GLmjFql1S2V+ITHRBikZjQjt1jo+Ucuj0aYrL+DUMw6X0WHe5J3wgYjKB/Z
 am4uZWEi2Cj4IsdKj+XENTZgEpksIdq7R+Jt0MvcaZZrOIlqapnX1PCWp+WJVO6BPEiQweTkE
 a7OM7igelptWVtIbd2JLlYi2ANqbhb4hOd5Ahq2PapnKmkY951UKjz80O4zkruZZKOLKgtDQ4
 okTdQYsnnYzXW44Le7arDuuCOC9wZfuofmLKM42ugdK/49VQc/GWPffs8A3Gpd6Yj3zHEl4om
 J1f6J/suPoGHxYtL4yK/nLiPPQ8PTN8l9s6JRdrGQCPfT0m3wun/fbjHFUmy8cJ4rr2noucmn
 c660ROZfKj9jNbPPwknzLNnMsAcF7JBznhLcNBucLDZ9yKpn9LQhT8EM1tyRHp/dg0OMLWo1i
 w6IcbHQOn2P1kSNg2ighjmcDlrFZSOIoSoe7HA43MkIfv1H9AOSMCJa2STd/Cy6ul0jeWu0rZ
 Ngnu5gZaCTsjHamo5fBdllpLaBTuwclA7K3EFZ/FIJO1az5z3k/RmC+TBBd5WmL/AG2f/prGb
 AIzXPwsVw3SDPv9cmM2SgedQWA6MRd25vAwFLt3/Op4kgxf+FdCwfSEEc12pYXhOm3mITZ7Gp
 5dI5OehFKrdb6A0wojisoQhdfUqu0+z3PRPs9P16zu+ugq4lQvOehd5gEBNZ2c6M+ZzO55L4q
 t5GSFJknFfmy/ATpwKm3vq70YCR7b2QsMm3Q3aPMRt680r1b9/ZYveR4h1uFCfAhjMDqOCEIk
 zSe6AW/+cHCJN4SJ1DCWymg9UIBVRtp4D9dohPvgf6IaCGI06gL6ZPDXxlosq5LuusOuUGfOU
 M9TDhIq4oznlBI75V704o7bMI5HsFPSYZGh3VrrFu6pPkIqC5NHU2wtdrr/GJaogLJkAAEhZW
 CtvchthcNqspn1a1mHmQrouzdUWJdzQLMwZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The branches of the "if" statement are the same. So remove the
unnecessary if and goto statements.

Addresses-Coverity-ID: 1456916 ("Identical code for different branches")
Fixes: 4c283fdac08ab ("drm/amd/display: Add HDCP module")
Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/=
drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index de872e7958b0..d0c565567102 100644
=2D-- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -305,10 +305,8 @@ static enum mod_hdcp_status wait_for_ready(struct mod=
_hdcp *hdcp,
 				hdcp, "bcaps_read"))
 			goto out;
 	}
-	if (!mod_hdcp_execute_and_set(check_ksv_ready,
-			&input->ready_check, &status,
-			hdcp, "ready_check"))
-		goto out;
+	mod_hdcp_execute_and_set(check_ksv_ready, &input->ready_check, &status,
+				 hdcp, "ready_check");
 out:
 	return status;
 }
=2D-
2.25.1

