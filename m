Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8606F41764E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbhIXN4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbhIXN4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:56:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D53C061613
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:54:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso7644906pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Kz5TrqcLU+ze8Yfi6qwiX1dvpIqN0ksd5g5a+3awDeg=;
        b=IGX6xsmxueczgFJR3x6mOdbU7KRPAnhnANNs+jc6CmAmQjVc2LlFTYhDk4c5eY9WSO
         mZxc+Uhoyr/PuybtyIxgtyOFIw/cTdm5nzqbZ1rcuPlv4TBJgI2cgl+cg3k3P85+5xqL
         UxeH7QhnVUDCEyORBzEnNLgW3IfN/8p+/hpcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Kz5TrqcLU+ze8Yfi6qwiX1dvpIqN0ksd5g5a+3awDeg=;
        b=IyXlkS9hs2lC5mMfBoa+4/xW5W/MEGCMy3W85cg6Pf1cjiTrrz38VGV5eWbpXGSWZM
         pHutDdNHrYceMIdbP8Jaj3UVR3kZIfFqOBN0K+f5KJvgSVLOV9GuuEBl+c1tYjtttCgP
         q1hBdvpjxmiTKaQY0dKfVHec3jyvx0G7rthCf+qizxQ/xZQQPieFPzGoea77hSGP1ljc
         6j2r9aRbEbGCKKrInB8jC88XuJPsI6xKZ4azuFiA/WxFhG5FugBYoImT7r2rwEp/gxsP
         S3H/xOQ3BPqpa1X1vnwyR393x8dpmxJrBXP8TJq0XDXwz53D1x6TADnaSuJP/ThEP6tW
         NSgQ==
X-Gm-Message-State: AOAM530CWxtWpeqvFsF9jDmKlQqskXVndoJmUjvn0HWPH5aPUiS3nOO/
        85wz6cOSpLmcwgJFDUAQHhf+jw==
X-Google-Smtp-Source: ABdhPJx/Dtx19wxdYEYlyQ/SP788dP1lFmKMoyuYgE00j90jxbMh3uBJ6+huVy4ts0WEaSERoq/ERg==
X-Received: by 2002:a17:90a:130f:: with SMTP id h15mr2428449pja.183.1632491677501;
        Fri, 24 Sep 2021 06:54:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:973:9109:7e32:e4da])
        by smtp.gmail.com with UTF8SMTPSA id n26sm9509706pfo.19.2021.09.24.06.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 06:54:37 -0700 (PDT)
Date:   Fri, 24 Sep 2021 06:54:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Zijun Hu <zijuhu@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org, tjiang@codeaurora.org
Subject: Re: [PATCH v10] Bluetooth: btusb: Add support using different nvm
 for variant WCN6855 controller
Message-ID: <YU3Ym8Oa9yJVqN44@google.com>
References: <1631614096-24613-1-git-send-email-zijuhu@codeaurora.org>
 <C7D16218-F9EF-4CF3-AFE1-C8589A8810D5@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C7D16218-F9EF-4CF3-AFE1-C8589A8810D5@holtmann.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 12:10:41PM +0200, Marcel Holtmann wrote:
> Hi Zijun,
> 
> > the RF performance of wcn6855 soc chip from different foundries will be
> > difference, so we should use different nvm to configure them.
> > 
> > Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
> > ---
> > drivers/bluetooth/btusb.c | 50 +++++++++++++++++++++++++++++++++++------------
> > 1 file changed, 37 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 928cbfa4c42d..6dc645698e30 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -3161,6 +3161,9 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
> > #define QCA_DFU_TIMEOUT		3000
> > #define QCA_FLAG_MULTI_NVM      0x80
> > 
> > +#define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
> > +#define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
> > +
> > struct qca_version {
> > 	__le32	rom_version;
> > 	__le32	patch_version;
> > @@ -3192,6 +3195,7 @@ static const struct qca_device_info qca_devices_table[] = {
> > 	{ 0x00000302, 28, 4, 16 }, /* Rome 3.2 */
> > 	{ 0x00130100, 40, 4, 16 }, /* WCN6855 1.0 */
> > 	{ 0x00130200, 40, 4, 16 }, /* WCN6855 2.0 */
> > +	{ 0x00130201, 40, 4, 16 }, /* WCN6855 2.1 */
> > };
> > 
> > static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
> > @@ -3346,6 +3350,31 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
> > 	return err;
> > }
> > 
> > +static void btusb_generate_qca_nvm_name(char *fwname,
> > +					size_t max_size,
> > +					struct qca_version *ver,
> > +					char *variant)
> > +{
> 
> you are really not listening to review feedback. Use “const char *variant”.

Yeah, also as I mentioned earlier, this function has all the information
to determine the variant itself, there is no need to clutter
btusb_setup_qca_load_nvm() and the interface of this function with
variant stuff, it should be internal business of btusb_generate_qca_nvm_name().

> 
> > +	char *sep = (strlen(variant) == 0) ? "" : "_";
> 
> This is crazy.

It can also go away if the function determines the variant itself.
