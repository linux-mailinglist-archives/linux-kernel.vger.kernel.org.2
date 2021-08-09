Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AD53E4B46
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 19:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhHIRzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 13:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232464AbhHIRzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:55:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B37F260E78;
        Mon,  9 Aug 2021 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628531710;
        bh=xt5HUGt3PKLJ5RZuYecvLk5allJyEl1mTduSPvyDnO0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kOQSutxxbkMJsjoK78auSzAw5REL24ZY99I1nNSZh/QbzXzgMb9NZTXeUVcwefUWE
         ynYFdakZzkypBhDG7HwX0mdwvhnykx6tp8HHg41T9Hcbog7CbgLLWAKnRwvP6vT3lm
         9C/y22aYDycMWlMOI6cuxNg1nng+ohUQg7zgB+2Nj9C9xHWSMjBc/57sngDTnjxGID
         S7BgVJxPO4H7OUHHW+suttm4ixzstakxqYVh94FJYdDSOxdQpYlQMpvy7TX4WazBYL
         d/YaSms0MIZBFdYUDHfQe7NQanD9IQDYNlkvbC3XJn7FUHPMa0oK0xGqXh1lHaKwj2
         GHN2r2vBQXZHA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1627972461-2627-4-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1627972461-2627-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1627972461-2627-4-git-send-email-hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH v10 3/5] spmi: mediatek: Add support for MT6873/8192
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 09 Aug 2021 10:55:09 -0700
Message-ID: <162853170949.1975443.12492156194100139076@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Hsiung Wang (2021-08-02 23:34:19)
> diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
> new file mode 100644
> index 000000000000..94c45d46ab0c
> --- /dev/null
> +++ b/drivers/spmi/spmi-mtk-pmif.c
> @@ -0,0 +1,465 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2021 MediaTek Inc.
> +
> +#include <linux/clk.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

include platform_device.h for the platform device driver that this is.

> +#include <linux/spmi.h>
> +
> +#define SWINF_IDLE     0x00
> +#define SWINF_WFVLDCLR 0x06
> +
> +#define GET_SWINF(x)   (((x) >> 1) & 0x7)
> +
> +#define PMIF_CMD_REG_0         0
> +#define PMIF_CMD_REG           1
> +#define PMIF_CMD_EXT_REG       2
> +#define PMIF_CMD_EXT_REG_LONG  3
> +
> +#define PMIF_DELAY_US   10
> +#define PMIF_TIMEOUT_US (10 * 1000)
> +
> +#define PMIF_CHAN_OFFSET 0x5
> +
> +#define PMIF_MAX_CLKS  3
> +
> +#define SPMI_OP_ST_BUSY 1
> +
> +struct ch_reg {
> +       u32 ch_sta;
> +       u32 wdata;
> +       u32 rdata;
> +       u32 ch_send;
> +       u32 ch_rdy;
> +};
> +
> +struct pmif_data {
> +       const u32       *regs;
> +       const u32       *spmimst_regs;
> +       u32     soc_chan;
> +};
> +
> +struct pmif {
> +       void __iomem    *base;
> +       void __iomem    *spmimst_base;
> +       struct ch_reg   chan;
> +       struct clk_bulk_data clks[PMIF_MAX_CLKS];
> +       u32 nclks;

size_t? Surely 32-bits isn't important.

> +       const struct pmif_data *data;
> +};
> +
> +static const char * const pmif_clock_names[] =3D {
> +       "pmif_sys_ck", "pmif_tmr_ck", "spmimst_clk_mux",
> +};
[...]
> +
> +static bool pmif_is_fsm_vldclr(struct pmif *arb)
> +{
> +       u32 reg_rdata;
> +
> +       reg_rdata =3D pmif_readl(arb, arb->chan.ch_sta);

Newline here please.

> +       return GET_SWINF(reg_rdata) =3D=3D SWINF_WFVLDCLR;
> +}
> +
> +static int pmif_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
> +{
> +       struct pmif *arb =3D spmi_controller_get_drvdata(ctrl);
> +       u32 rdata, cmd;
> +       int ret;
> +
> +       /* Check the opcode */
> +       if (opc < SPMI_CMD_RESET || opc > SPMI_CMD_WAKEUP)
> +               return -EINVAL;
> +
> +       cmd =3D opc - SPMI_CMD_RESET;
> +
> +       mtk_spmi_writel(arb, (cmd << 0x4) | sid, SPMI_OP_ST_CTRL);
> +       ret =3D readl_poll_timeout_atomic(arb->spmimst_base + arb->data->=
spmimst_regs[SPMI_OP_ST_STA],
> +                                       rdata, (rdata & SPMI_OP_ST_BUSY) =
=3D=3D SPMI_OP_ST_BUSY,
> +                                       PMIF_DELAY_US, PMIF_TIMEOUT_US);
> +       if (ret < 0)
> +               dev_err(&ctrl->dev, "timeout, err =3D %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 s=
id,
> +                             u16 addr, u8 *buf, size_t len)
> +{
> +       struct pmif *arb =3D spmi_controller_get_drvdata(ctrl);
> +       struct ch_reg *inf_reg;
> +       int ret;
> +       u32 data, cmd;
> +
> +       /* Check for argument validation. */
> +       if (sid & ~0xf) {
> +               dev_err(&ctrl->dev, "exceed the max slv id\n");
> +               return -EINVAL;
> +       }
> +
> +       if (len > 4) {
> +               dev_err(&ctrl->dev, "pmif supports 1..4 bytes per trans, =
but:%zu requested", len);

Missing newline

> +               return -EINVAL;
> +       }
> +
> +       if (opc >=3D 0x60 && opc <=3D 0x7f)
> +               opc =3D PMIF_CMD_REG;
> +       else if ((opc >=3D 0x20 && opc <=3D 0x2f) || (opc >=3D 0x38 && op=
c <=3D 0x3f))
> +               opc =3D PMIF_CMD_EXT_REG_LONG;
> +       else
> +               return -EINVAL;
> +
> +       /* Wait for Software Interface FSM state to be IDLE. */
> +       inf_reg =3D &arb->chan;
> +       ret =3D readl_poll_timeout_atomic(arb->base + arb->data->regs[inf=
_reg->ch_sta],
> +                                       data, GET_SWINF(data) =3D=3D SWIN=
F_IDLE,
> +                                       PMIF_DELAY_US, PMIF_TIMEOUT_US);
> +       if (ret < 0) {
> +               /* set channel ready if the data has transferred */
> +               if (pmif_is_fsm_vldclr(arb))
> +                       pmif_writel(arb, 1, inf_reg->ch_rdy);
> +               dev_err(&ctrl->dev, "failed to wait for SWINF_IDLE\n");
> +               goto out;
> +       }
> +
> +       /* Send the command. */
> +       cmd =3D (opc << 30) | (sid << 24) | ((len - 1) << 16) | addr;
> +       pmif_writel(arb, cmd, inf_reg->ch_send);
> +
> +       /*
> +        * Wait for Software Interface FSM state to be WFVLDCLR,
> +        * read the data and clear the valid flag.
> +        */
> +       ret =3D readl_poll_timeout_atomic(arb->base + arb->data->regs[inf=
_reg->ch_sta],
> +                                       data, GET_SWINF(data) =3D=3D SWIN=
F_WFVLDCLR,
> +                                       PMIF_DELAY_US, PMIF_TIMEOUT_US);
> +       if (ret < 0) {
> +               dev_err(&ctrl->dev, "failed to wait for SWINF_WFVLDCLR\n"=
);
> +               goto out;
> +       }
> +
> +       data =3D pmif_readl(arb, inf_reg->rdata);
> +       memcpy(buf, &data, len);
> +       pmif_writel(arb, 1, inf_reg->ch_rdy);
> +
> +out:
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 =
sid,
> +                              u16 addr, const u8 *buf, size_t len)
> +{
> +       struct pmif *arb =3D spmi_controller_get_drvdata(ctrl);
> +       struct ch_reg *inf_reg;
> +       int ret;
> +       u32 data, cmd;
> +
> +       if (len > 4) {
> +               dev_err(&ctrl->dev, "pmif supports 1..4 bytes per trans, =
but:%zu requested", len);

Missing newline

> +               return -EINVAL;
> +       }
> +
> +       /* Check the opcode */
> +       if (opc >=3D 0x40 && opc <=3D 0x5F)
> +               opc =3D PMIF_CMD_REG;
> +       else if ((opc <=3D 0xF) || (opc >=3D 0x30 && opc <=3D 0x37))
> +               opc =3D PMIF_CMD_EXT_REG_LONG;
> +       else if (opc >=3D 0x80)
> +               opc =3D PMIF_CMD_REG_0;
> +       else
> +               return -EINVAL;
> +
> +       /* Wait for Software Interface FSM state to be IDLE. */
> +       inf_reg =3D &arb->chan;
> +       ret =3D readl_poll_timeout_atomic(arb->base + arb->data->regs[inf=
_reg->ch_sta],
> +                                       data, GET_SWINF(data) =3D=3D SWIN=
F_IDLE,
> +                                       PMIF_DELAY_US, PMIF_TIMEOUT_US);
> +       if (ret < 0) {
> +               /* set channel ready if the data has transferred */
> +               if (pmif_is_fsm_vldclr(arb))
> +                       pmif_writel(arb, 1, inf_reg->ch_rdy);
> +               dev_err(&ctrl->dev, "failed to wait for SWINF_IDLE\n");
> +               goto out;
> +       }
> +
> +       /* Set the write data. */
> +       memcpy(&data, buf, len);
> +       pmif_writel(arb, data, inf_reg->wdata);
> +
> +       /* Send the command. */
> +       cmd =3D (opc << 30) | BIT(29) | (sid << 24) | ((len - 1) << 16) |=
 addr;
> +       pmif_writel(arb, cmd, inf_reg->ch_send);
> +
> +out:
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;

Simplify to=20

	out:
		return ret;

> +}
> +
> +static const struct pmif_data mt6873_pmif_arb =3D {
> +       .regs =3D mt6873_regs,
> +       .spmimst_regs =3D mt6873_spmi_regs,
> +       .soc_chan =3D 2,
> +};
> +
> +static int mtk_spmi_probe(struct platform_device *pdev)
> +{
> +       struct pmif *arb;
> +       struct spmi_controller *ctrl;
> +       int err, i;
> +       u32 chan_offset;
> +
> +       ctrl =3D spmi_controller_alloc(&pdev->dev, sizeof(*arb));
> +       if (!ctrl)
> +               return -ENOMEM;
> +
> +       arb =3D spmi_controller_get_drvdata(ctrl);
> +       arb->data =3D of_device_get_match_data(&pdev->dev);

Use device_get_match_data() instead please.

> +       if (!arb->data) {
> +               err =3D -EINVAL;
> +               dev_err(&pdev->dev, "Cannot get drv_data\n");
> +               goto err_put_ctrl;
> +       }
> +
> +       arb->base =3D devm_platform_ioremap_resource_byname(pdev, "pmif");
> +       if (IS_ERR(arb->base)) {
> +               err =3D PTR_ERR(arb->base);
> +               dev_err(&pdev->dev, "pmif failed to get the remappped mem=
ory\n");

Please drop print as the API already prints errors for every problem.

> +               goto err_put_ctrl;
> +       }
> +
> +       arb->spmimst_base =3D devm_platform_ioremap_resource_byname(pdev,=
 "spmimst");
> +       if (IS_ERR(arb->spmimst_base)) {
> +               err =3D PTR_ERR(arb->spmimst_base);
> +               dev_err(&pdev->dev, "spmimst failed to get the remappped =
memory\n");

Please drop print as the API already prints errors for every problem.

> +               goto err_put_ctrl;
> +       }
> +
> +       arb->nclks =3D ARRAY_SIZE(pmif_clock_names);
> +       if (arb->nclks > PMIF_MAX_CLKS) {
> +               err =3D -EINVAL;
> +               dev_err(&pdev->dev, "exceed the max clock numbers\n");

Do we really care? The dt schema should be checking this instead of the
driver.

> +               goto err_put_ctrl;
> +       }
> +
> +       for (i =3D 0; i < arb->nclks; i++)
> +               arb->clks[i].id =3D pmif_clock_names[i];
> +
