Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09E9352E4A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhDBRae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbhDBRaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37BFC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c8so5286891wrq.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xeDid1qnJEENj9WSCIRwSBis6QOEga/41uImp5Q74g=;
        b=h+E7qksOk8WsELaGuFj5p3FKkDlbkaP9YdbqZ/NQIm4HgsTHMB0CS00FB1uBVaJHhD
         WiIUl+PqjoDwH86GQE07C2aju6hDTDrJOr4/dS2KU4sZhIIR9wiCtlnJMyvwoE1ddnwA
         vZtkomr5vsN8ryrSv9vmhxlndNWa/5sxK5tvl22f8VKe5JxrJT/zYIyhl59gkAaQm+7f
         y1RC8wwzF4yKfX8SZhfIH7KKT2fyY63O5lv+kPX5ZXI7n9oJTRXVd4X5WU1xK67MBWQw
         XN5jOGxPhq05Oc2ESheGmdOkKPBcyqrBEdBHiOoaR9Owu4pDSMnwXwvDKwN8SFe6OgJm
         HMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xeDid1qnJEENj9WSCIRwSBis6QOEga/41uImp5Q74g=;
        b=XN+xFZ9gyyiVZP2er147AZscEu46nzKbYnP/pWyWS1ifW4Sr+nHLKq6faDblUuMOIu
         7TQey4Ub8L/YzCvrKfx+wApgULkCobw/FbrFENIsrNpPv3aJTB0096MKPDg4CDqjdjT1
         KRdU/Fxop985akb/ozhXicoo+H9FiUKan8UhhWZfYvxsJ4I2hULJiUpUA5b04jxyPppy
         7zcAczTBTy1mFvyrCmzstJDJ/0rCar6hlPPhz9fMmMbbassOEWNDGOSYJ11ePCOFfVgL
         /x5Pxhgv61bDjb5gfNYZ508j0shpwllPI0jrLpmPtm5J8GHKLiANe8zrUFhFOwlqgNjQ
         LabA==
X-Gm-Message-State: AOAM531C3lCvThhmlEkqTQihLa768eS/owS5XJe4b5B8H5ASxMmXku/M
        KZFGOIIcBOKXSpJgLXbg0fHsrOlke9ktnQ==
X-Google-Smtp-Source: ABdhPJwiQeuTj+Pz1Ldvg4ynGsSxHSl84qcE+3JZG/0tivPbau90HL1pO3herHWjD8wLklxdUdBOeA==
X-Received: by 2002:a5d:4b43:: with SMTP id w3mr16502204wrs.406.1617384620648;
        Fri, 02 Apr 2021 10:30:20 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id u9sm11850358wmq.30.2021.04.02.10.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 02/30] staging: rtl8723bs: fix condition in if statement
Date:   Fri,  2 Apr 2021 19:29:44 +0200
Message-Id: <0c394ddaeda95d55384636152896b65ed34fc9e4.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix condition warned by post-hook checkpatch

CHECK: Using comparison to true is error prone
71: FILE: drivers/staging/rtl8723bs/core/rtw_xmit.c:565:
+		((padapter->securitypriv.sw_encrypt == true) ||
		 (psecuritypriv->hw_decrypted == false)))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index beee87db85a5..957d7e3a4d4a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -562,7 +562,7 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 		memcpy(pattrib->dot118021x_UncstKey.skey, psta->dot118021x_UncstKey.skey, 16);
 
 	if (pattrib->encrypt &&
-		((padapter->securitypriv.sw_encrypt == true) || (psecuritypriv->hw_decrypted == false)))
+		((padapter->securitypriv.sw_encrypt) || (!psecuritypriv->hw_decrypted)))
 		pattrib->bswenc = true;
 	else
 		pattrib->bswenc = false;
-- 
2.20.1

