Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9B3F5D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbhHXLXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbhHXLXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:23:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6AC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 04:22:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d11so43505772eja.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 04:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8W2+3arloXezOP0E5J73Ksz+WJOizO3Gg+lSH91G+jI=;
        b=TQnQ6Z5VhexI/i2F+UEp6T1e4RzzWlHXM6o0AdmRBeUrRqsy4QjjJ0XTG24SaHzTHa
         7EsaN3IK1pzJBSSFQ5HZ0lIXxObeAakTmIgJF18V/py94yll4ViB7fMUw5JY5dFhTUl4
         +duDpvm46oHaQTzmF2CLoXrWQUqlP8C71u+VYUIPiXJ1VYwm2RbFwfSdCPbXcQw6k5aX
         F/XY/JxHxO5MQCRO4Pr3LAEAgAbWShliVrnamfpQEnSnzVbJvxT+VdNTWsIzlb8GaN4p
         zDF/fHK4CubkQP9l0pSWu4zyZ6uQbfjMUj/iiTXykMy2nDTGQzATIHVm0Zd8EwVD0ql5
         WkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8W2+3arloXezOP0E5J73Ksz+WJOizO3Gg+lSH91G+jI=;
        b=OidKmdzPHfjMdZ8o3KQH0xXPrwwQvNMqVA9k/4yZzKCDVDyytm5xyPogExhK8CxDJU
         gpYNjxxVHUoDcA7qZUyqDFCrm5NzHs/cf5wajAKuFKZ+r5nwwembSZuMKynoVhvSe4uU
         bc4GzYDeuyBV+1wuDHzciLTq/2a9KmOWfMf04Frm62/lkPdbg+AHS7Zs7TZQiVQ5By6J
         GhTiB5/6oJ9104rq9zRw+/U8S9+YrL3w4WkrRMfd2Q/I5iR8vuvCHmNeCZxHBRvMAXJR
         trZh2F2y+H+yTxjG7+Yo/B9sGzZ5Fs/J+DiZpTKWFecm1xg/73pRALrimBAkNYoU01za
         S+bw==
X-Gm-Message-State: AOAM5311Bk3cTLZ235UsRKMAQk+RVS6u1p5V4zxUBOyjZJeohbs/qxwE
        R0fbELhvKGCIbHMGm3tIkIoR9rClZVaiw5oZcJqOuQ==
X-Google-Smtp-Source: ABdhPJzD1thelmLkt9dUDPHIIz/5wJlz3G1EUbAPNvStEVf8XtCVH7Hi8g4xzc2XvwsfN2SBv8VdUp79kjRKHc6G2Uo=
X-Received: by 2002:a17:906:a0c9:: with SMTP id bh9mr8404843ejb.51.1629804156024;
 Tue, 24 Aug 2021 04:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210823162916.824336-1-benjamin.gaignard@collabora.com>
In-Reply-To: <20210823162916.824336-1-benjamin.gaignard@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 24 Aug 2021 08:22:24 -0300
Message-ID: <CAAEAJfCxhe8EubESc4HnO63JnOqVCRTNU62Qrm8wX+Rsc_tSUg@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: Add support of compressed reference buffers
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Mon, 23 Aug 2021 at 13:29, Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
> Reference frame compression is a feature added in G2 decoder to compress
> frame buffers so that the bandwidth of storing/loading reference frames
> can be reduced, especially when the resolution of decoded stream is of
> high definition.
>
> Compressed help to increase the performance of the whole stack, it could
> be up to 50 fps (against 45 fps) on IMX8MQ.
> The impact of compressed frames is confirmed when using perf to monitor
> the number of memory accesses with or without compression feature.
> The following command
> perf stat -a -e imx8_ddr0/cycles/,imx8_ddr0/read-cycles/,imx8_ddr0/write-cycles/ gst-launch-1.0 filesrc location=Jockey_3840x2160_120fps_420_8bit_HEVC_RAW.hevc ! queue ! h265parse ! v4l2slh265dec ! fakesink
>
> give us these results
> without compression feature:
>  Performance counter stats for 'system wide':
>
>        14965816743      imx8_ddr0/cycles/
>          889197312      imx8_ddr0/read-cycles/
>         1819348862      imx8_ddr0/write-cycles/
>
>       18.707373001 seconds time elapsed
>
> with compression feature:
> Performance counter stats for 'system wide':
>
>        13750218243      imx8_ddr0/cycles/
>          402428744      imx8_ddr0/read-cycles/
>         1255676693      imx8_ddr0/write-cycles/
>
>       17.188320061 seconds time elapsed
>
> As expected the number of read/write cycles are really lower when compression
> is used.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../staging/media/hantro/hantro_g2_hevc_dec.c | 31 ++++++++++++--
>  drivers/staging/media/hantro/hantro_g2_regs.h |  4 ++
>  drivers/staging/media/hantro/hantro_hevc.c    | 41 ++++++++++++++++++-
>  drivers/staging/media/hantro/hantro_hw.h      |  2 +
>  4 files changed, 74 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> index 340efb57fd18..da90acd922f7 100644
> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> @@ -366,10 +366,12 @@ static int set_ref(struct hantro_ctx *ctx)
>         const struct v4l2_ctrl_hevc_pps *pps = ctrls->pps;
>         const struct v4l2_ctrl_hevc_decode_params *decode_params = ctrls->decode_params;
>         const struct v4l2_hevc_dpb_entry *dpb = decode_params->dpb;
> -       dma_addr_t luma_addr, chroma_addr, mv_addr = 0;
> +       dma_addr_t luma_addr, chroma_addr, mv_addr, compress_luma_addr, compress_chroma_addr = 0;
>         struct hantro_dev *vpu = ctx->dev;
>         size_t cr_offset = hantro_hevc_chroma_offset(sps);
>         size_t mv_offset = hantro_hevc_motion_vectors_offset(sps);
> +       size_t compress_luma_offset = hantro_hevc_luma_compress_offset(sps);
> +       size_t compress_chroma_offset = hantro_hevc_chroma_compress_offset(sps);
>         u32 max_ref_frames;
>         u16 dpb_longterm_e;
>         static const struct hantro_reg cur_poc[] = {
> @@ -442,15 +444,28 @@ static int set_ref(struct hantro_ctx *ctx)
>                 if (!luma_addr)
>                         return -ENOMEM;
>
> +               /*
> +                * An allocated frame stores Y and UV planes, motion vectors and
> +                * compressed Y and UV planes. Compute all these offsets given
> +                * the frame resolution and the pixel format.
> +                */

The patch looks good, but I feel we still need to answer some questions
before it can be merged.

* Is this a G2 feature? If so, can it be used on VP9?

* Enabling compression needs more memory. You are proposing
to allocate frames and compressed frames contiguously,
but so we need to measure the impact of that. Perhaps separate
buffers will be better to avoid CMA pressure? Perhaps a given
user will want to turn this off to reduce memory usage?

More importantly, I'm wary of adding HEVC features
without being able to test anything.

Can you work with NXP maintainers to get the GPC/BLK-CTRL [1] sorted out?

Then, we have the issue of missing mainlined userspace as well,
but I suppose that's well underway :-)

[1] https://www.spinics.net/lists/arm-kernel/msg913881.html

Cheers,
Eze

>                 chroma_addr = luma_addr + cr_offset;
>                 mv_addr = luma_addr + mv_offset;
> +               compress_luma_addr = luma_addr + compress_luma_offset;
> +               compress_chroma_addr = luma_addr + compress_chroma_offset;
>
>                 if (dpb[i].rps == V4L2_HEVC_DPB_ENTRY_RPS_LT_CURR)
>                         dpb_longterm_e |= BIT(V4L2_HEVC_DPB_ENTRIES_NUM_MAX - 1 - i);
>
> +               /*
> +                * For each reference frame Y, UV, motion vector and
> +                * compressed Y, UV buffers addresses must be set.
> +                */
>                 hantro_write_addr(vpu, G2_REG_ADDR_REF(i), luma_addr);
>                 hantro_write_addr(vpu, G2_REG_CHR_REF(i), chroma_addr);
>                 hantro_write_addr(vpu, G2_REG_DMV_REF(i), mv_addr);
> +               hantro_write_addr(vpu, G2_COMP_ADDR_REF(i), compress_luma_addr);
> +               hantro_write_addr(vpu, G2_COMP_CHR_REF(i), compress_chroma_addr);
>         }
>
>         luma_addr = hantro_hevc_get_ref_buf(ctx, decode_params->pic_order_cnt_val);
> @@ -459,7 +474,12 @@ static int set_ref(struct hantro_ctx *ctx)
>
>         chroma_addr = luma_addr + cr_offset;
>         mv_addr = luma_addr + mv_offset;
> +       compress_luma_addr = luma_addr + compress_luma_offset;
> +       compress_chroma_addr = luma_addr + compress_chroma_offset;
>
> +       /* The next decoded frame as to be put as the last reference frame entry */
> +       hantro_write_addr(vpu, G2_COMP_ADDR_REF(i), compress_luma_addr);
> +       hantro_write_addr(vpu, G2_COMP_CHR_REF(i), compress_chroma_addr);
>         hantro_write_addr(vpu, G2_REG_ADDR_REF(i), luma_addr);
>         hantro_write_addr(vpu, G2_REG_CHR_REF(i), chroma_addr);
>         hantro_write_addr(vpu, G2_REG_DMV_REF(i++), mv_addr);
> @@ -467,13 +487,18 @@ static int set_ref(struct hantro_ctx *ctx)
>         hantro_write_addr(vpu, G2_ADDR_DST, luma_addr);
>         hantro_write_addr(vpu, G2_ADDR_DST_CHR, chroma_addr);
>         hantro_write_addr(vpu, G2_ADDR_DST_MV, mv_addr);
> +       hantro_write_addr(vpu, G2_COMP_ADDR_DST, compress_luma_addr);
> +       hantro_write_addr(vpu, G2_COMP_CHR, compress_chroma_addr);
>
>         hantro_hevc_ref_remove_unused(ctx);
>
> +       /* Unused reference frames entries most be cleared */
>         for (; i < V4L2_HEVC_DPB_ENTRIES_NUM_MAX; i++) {
>                 hantro_write_addr(vpu, G2_REG_ADDR_REF(i), 0);
>                 hantro_write_addr(vpu, G2_REG_CHR_REF(i), 0);
>                 hantro_write_addr(vpu, G2_REG_DMV_REF(i), 0);
> +               hantro_write_addr(vpu, G2_COMP_ADDR_REF(i), 0);
> +               hantro_write_addr(vpu, G2_COMP_CHR_REF(i), 0);
>         }
>
>         hantro_reg_write(vpu, &g2_refer_lterm_e, dpb_longterm_e);
> @@ -564,8 +589,8 @@ int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx)
>         /* Don't disable output */
>         hantro_reg_write(vpu, &g2_out_dis, 0);
>
> -       /* Don't compress buffers */
> -       hantro_reg_write(vpu, &g2_ref_compress_bypass, 1);
> +       /* Compress buffers */
> +       hantro_reg_write(vpu, &g2_ref_compress_bypass, 0);
>
>         /* use NV12 as output format */
>         hantro_reg_write(vpu, &g2_out_rs_e, 1);
> diff --git a/drivers/staging/media/hantro/hantro_g2_regs.h b/drivers/staging/media/hantro/hantro_g2_regs.h
> index bb22fa921914..2a23e8657db1 100644
> --- a/drivers/staging/media/hantro/hantro_g2_regs.h
> +++ b/drivers/staging/media/hantro/hantro_g2_regs.h
> @@ -191,6 +191,10 @@
>  #define G2_TILE_FILTER         (G2_SWREG(179))
>  #define G2_TILE_SAO            (G2_SWREG(181))
>  #define G2_TILE_BSD            (G2_SWREG(183))
> +#define G2_COMP_ADDR_DST       (G2_SWREG(190))
> +#define G2_COMP_ADDR_REF(i)    (G2_SWREG(192) + ((i) * 0x8))
> +#define G2_COMP_CHR            (G2_SWREG(224))
> +#define G2_COMP_CHR_REF(i)     (G2_SWREG(226) + ((i) * 0x8))
>
>  #define g2_strm_buffer_len     G2_DEC_REG(258, 0, 0xffffffff)
>  #define g2_strm_start_offset   G2_DEC_REG(259, 0, 0xffffffff)
> diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
> index 5347f5a41c2a..78e5ceda520c 100644
> --- a/drivers/staging/media/hantro/hantro_hevc.c
> +++ b/drivers/staging/media/hantro/hantro_hevc.c
> @@ -27,6 +27,13 @@
>
>  #define G2_ALIGN               16
>
> +#define CBS_SIZE       16      /* compression table size in bytes */
> +#define CBS_LUMA       8       /* luminance CBS is composed of 1 8x8 coded block */
> +#define CBS_CHROMA_W   (8 * 2) /* chrominance CBS is composed of two 8x4 coded
> +                                * blocks, with Cb CB first then Cr CB following
> +                                */
> +#define CBS_CHROMA_H   4
> +
>  size_t hantro_hevc_chroma_offset(const struct v4l2_ctrl_hevc_sps *sps)
>  {
>         int bytes_per_pixel = sps->bit_depth_luma_minus8 == 0 ? 1 : 2;
> @@ -61,12 +68,44 @@ static size_t hantro_hevc_mv_size(const struct v4l2_ctrl_hevc_sps *sps)
>         return mv_size;
>  }
>
> +size_t hantro_hevc_luma_compress_offset(const struct v4l2_ctrl_hevc_sps *sps)
> +{
> +       return hantro_hevc_motion_vectors_offset(sps) + hantro_hevc_mv_size(sps);
> +}
> +
> +static size_t hantro_hevc_luma_compress_size(const struct v4l2_ctrl_hevc_sps *sps)
> +{
> +       u32 pic_width_in_cbsy =
> +               round_up((sps->pic_width_in_luma_samples + CBS_LUMA - 1) / CBS_LUMA, CBS_SIZE);
> +       u32 pic_height_in_cbsy = (sps->pic_height_in_luma_samples + CBS_LUMA - 1) / CBS_LUMA;
> +
> +       return round_up(pic_width_in_cbsy * pic_height_in_cbsy, CBS_SIZE);
> +}
> +
> +size_t hantro_hevc_chroma_compress_offset(const struct v4l2_ctrl_hevc_sps *sps)
> +{
> +       return hantro_hevc_luma_compress_offset(sps) + hantro_hevc_luma_compress_size(sps);
> +}
> +
> +static size_t hantro_hevc_chroma_compress_size(const struct v4l2_ctrl_hevc_sps *sps)
> +{
> +       u32 pic_width_in_cbsc =
> +               round_up((sps->pic_width_in_luma_samples + CBS_CHROMA_W - 1)
> +                        / CBS_CHROMA_W, CBS_SIZE);
> +       u32 pic_height_in_cbsc = (sps->pic_height_in_luma_samples / 2 + CBS_CHROMA_H - 1)
> +                                / CBS_CHROMA_H;
> +
> +       return round_up(pic_width_in_cbsc * pic_height_in_cbsc, CBS_SIZE);
> +}
> +
>  static size_t hantro_hevc_ref_size(struct hantro_ctx *ctx)
>  {
>         const struct hantro_hevc_dec_ctrls *ctrls = &ctx->hevc_dec.ctrls;
>         const struct v4l2_ctrl_hevc_sps *sps = ctrls->sps;
>
> -       return hantro_hevc_motion_vectors_offset(sps) + hantro_hevc_mv_size(sps);
> +       return hantro_hevc_motion_vectors_offset(sps) + hantro_hevc_mv_size(sps) +
> +              hantro_hevc_luma_compress_size(sps) +
> +              hantro_hevc_chroma_compress_size(sps);
>  }
>
>  static void hantro_hevc_ref_free(struct hantro_ctx *ctx)
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index df7b5e3a57b9..d5c002d0e765 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -255,6 +255,8 @@ dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, int poc);
>  void hantro_hevc_ref_remove_unused(struct hantro_ctx *ctx);
>  size_t hantro_hevc_chroma_offset(const struct v4l2_ctrl_hevc_sps *sps);
>  size_t hantro_hevc_motion_vectors_offset(const struct v4l2_ctrl_hevc_sps *sps);
> +size_t hantro_hevc_luma_compress_offset(const struct v4l2_ctrl_hevc_sps *sps);
> +size_t hantro_hevc_chroma_compress_offset(const struct v4l2_ctrl_hevc_sps *sps);
>
>  static inline size_t
>  hantro_h264_mv_size(unsigned int width, unsigned int height)
> --
> 2.25.1
>
