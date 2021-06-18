Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB533AC3E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhFRGbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhFRGbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:31:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7733D60C41;
        Fri, 18 Jun 2021 06:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623997773;
        bh=z12fjL1a8le96vSRPtQRaXK3eAiUTafmKbCmikTdOAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWfbaxBLznFujsRsqfACHesl/j8rcydlGp+FxjfDUZU5rzm4gDeWDv39qFmW1fES7
         R2NgYhO8l+mc5HDytoFxgXXp/WbH5oJM6NSMtQIz4h3bTWbmxSwyBwHV43Ni2hE0wq
         B2pLPZG28hIFQchduKc4af/k6Tfz/syqrkBA0sswrUdE0i/aQczDDhwJVSid9Qt8x8
         xTckVntMa059MRDvB7IcHA+Ybbu34by/5T8XIEjODLsZNObimh6Xj0YuTT5Rh/bh8f
         CkU6C3gnlzmyBLRAQlTe95v3ihNcJDs7j/pRtpyay3S6ouz9/8k+9yGw1ETuf96l/y
         L75HCxvMMuFrA==
Date:   Fri, 18 Jun 2021 11:59:27 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Paul Davey <paul.davey@alliedtelesis.co.nz>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bus: mhi: Fix MHI DMA structure endianness
Message-ID: <20210618062927.GK3682@workstation>
References: <20210618033132.24839-1-paul.davey@alliedtelesis.co.nz>
 <20210618033132.24839-3-paul.davey@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618033132.24839-3-paul.davey@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Hemant, Bhaumik, Jeff

On Fri, Jun 18, 2021 at 03:31:32PM +1200, Paul Davey wrote:
> The MHI driver does not work on big endian architectures.  The
> controller never transitions into mission mode.  This appears to be due
> to the modem device expecting the various contexts and transfer rings to
> have fields in little endian order in memory, but the driver constructs
> them in native endianness.
> 
> Fix MHI event, channel and command contexts and TRE handling macros to
> use explicit conversion to little endian.  Mark fields in relevant
> structures as little endian to document this requirement.
> 
> Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>

Patch looks good to me but I need more eyes to review this patch to make
sure nothing is missed.

Hemant, Bhaumik, Jeff: Could you please review this patch? And if possible,
please do the testing on x86/ARM64.

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/debugfs.c  |  26 +++----
>  drivers/bus/mhi/core/init.c     |  36 ++++-----
>  drivers/bus/mhi/core/internal.h | 129 ++++++++++++++++----------------
>  drivers/bus/mhi/core/main.c     |  36 ++++-----
>  drivers/bus/mhi/core/pm.c       |   8 +-
>  5 files changed, 119 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/debugfs.c b/drivers/bus/mhi/core/debugfs.c
> index 858d7516410b..d818586c229d 100644
> --- a/drivers/bus/mhi/core/debugfs.c
> +++ b/drivers/bus/mhi/core/debugfs.c
> @@ -60,16 +60,16 @@ static int mhi_debugfs_events_show(struct seq_file *m, void *d)
>  		}
>  
>  		seq_printf(m, "Index: %d intmod count: %lu time: %lu",
> -			   i, (er_ctxt->intmod & EV_CTX_INTMODC_MASK) >>
> +			   i, (le32_to_cpu(er_ctxt->intmod) & EV_CTX_INTMODC_MASK) >>
>  			   EV_CTX_INTMODC_SHIFT,
> -			   (er_ctxt->intmod & EV_CTX_INTMODT_MASK) >>
> +			   (le32_to_cpu(er_ctxt->intmod) & EV_CTX_INTMODT_MASK) >>
>  			   EV_CTX_INTMODT_SHIFT);
>  
> -		seq_printf(m, " base: 0x%0llx len: 0x%llx", er_ctxt->rbase,
> -			   er_ctxt->rlen);
> +		seq_printf(m, " base: 0x%0llx len: 0x%llx", le64_to_cpu(er_ctxt->rbase),
> +			   le64_to_cpu(er_ctxt->rlen));
>  
> -		seq_printf(m, " rp: 0x%llx wp: 0x%llx", er_ctxt->rp,
> -			   er_ctxt->wp);
> +		seq_printf(m, " rp: 0x%llx wp: 0x%llx", le64_to_cpu(er_ctxt->rp),
> +			   le64_to_cpu(er_ctxt->wp));
>  
>  		seq_printf(m, " local rp: 0x%pK db: 0x%pad\n", ring->rp,
>  			   &mhi_event->db_cfg.db_val);
> @@ -106,18 +106,18 @@ static int mhi_debugfs_channels_show(struct seq_file *m, void *d)
>  
>  		seq_printf(m,
>  			   "%s(%u) state: 0x%lx brstmode: 0x%lx pollcfg: 0x%lx",
> -			   mhi_chan->name, mhi_chan->chan, (chan_ctxt->chcfg &
> +			   mhi_chan->name, mhi_chan->chan, (le32_to_cpu(chan_ctxt->chcfg) &
>  			   CHAN_CTX_CHSTATE_MASK) >> CHAN_CTX_CHSTATE_SHIFT,
> -			   (chan_ctxt->chcfg & CHAN_CTX_BRSTMODE_MASK) >>
> -			   CHAN_CTX_BRSTMODE_SHIFT, (chan_ctxt->chcfg &
> +			   (le32_to_cpu(chan_ctxt->chcfg) & CHAN_CTX_BRSTMODE_MASK) >>
> +			   CHAN_CTX_BRSTMODE_SHIFT, (le32_to_cpu(chan_ctxt->chcfg) &
>  			   CHAN_CTX_POLLCFG_MASK) >> CHAN_CTX_POLLCFG_SHIFT);
>  
> -		seq_printf(m, " type: 0x%x event ring: %u", chan_ctxt->chtype,
> -			   chan_ctxt->erindex);
> +		seq_printf(m, " type: 0x%x event ring: %u", le32_to_cpu(chan_ctxt->chtype),
> +			   le32_to_cpu(chan_ctxt->erindex));
>  
>  		seq_printf(m, " base: 0x%llx len: 0x%llx rp: 0x%llx wp: 0x%llx",
> -			   chan_ctxt->rbase, chan_ctxt->rlen, chan_ctxt->rp,
> -			   chan_ctxt->wp);
> +			   le64_to_cpu(chan_ctxt->rbase), le64_to_cpu(chan_ctxt->rlen),
> +			   le64_to_cpu(chan_ctxt->rp), le64_to_cpu(chan_ctxt->wp));
>  
>  		seq_printf(m, " local rp: 0x%pK local wp: 0x%pK db: 0x%pad\n",
>  			   ring->rp, ring->wp,
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 87cc0c449078..9515a6c50f23 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -291,17 +291,17 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
>  		if (mhi_chan->offload_ch)
>  			continue;
>  
> -		tmp = chan_ctxt->chcfg;
> +		tmp = le32_to_cpu(chan_ctxt->chcfg);
>  		tmp &= ~CHAN_CTX_CHSTATE_MASK;
>  		tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
>  		tmp &= ~CHAN_CTX_BRSTMODE_MASK;
>  		tmp |= (mhi_chan->db_cfg.brstmode << CHAN_CTX_BRSTMODE_SHIFT);
>  		tmp &= ~CHAN_CTX_POLLCFG_MASK;
>  		tmp |= (mhi_chan->db_cfg.pollcfg << CHAN_CTX_POLLCFG_SHIFT);
> -		chan_ctxt->chcfg = tmp;
> +		chan_ctxt->chcfg = cpu_to_le32(tmp);
>  
> -		chan_ctxt->chtype = mhi_chan->type;
> -		chan_ctxt->erindex = mhi_chan->er_index;
> +		chan_ctxt->chtype = cpu_to_le32(mhi_chan->type);
> +		chan_ctxt->erindex = cpu_to_le32(mhi_chan->er_index);
>  
>  		mhi_chan->ch_state = MHI_CH_STATE_DISABLED;
>  		mhi_chan->tre_ring.db_addr = (void __iomem *)&chan_ctxt->wp;
> @@ -326,14 +326,14 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
>  		if (mhi_event->offload_ev)
>  			continue;
>  
> -		tmp = er_ctxt->intmod;
> +		tmp = le32_to_cpu(er_ctxt->intmod);
>  		tmp &= ~EV_CTX_INTMODC_MASK;
>  		tmp &= ~EV_CTX_INTMODT_MASK;
>  		tmp |= (mhi_event->intmod << EV_CTX_INTMODT_SHIFT);
> -		er_ctxt->intmod = tmp;
> +		er_ctxt->intmod = cpu_to_le32(tmp);
>  
> -		er_ctxt->ertype = MHI_ER_TYPE_VALID;
> -		er_ctxt->msivec = mhi_event->irq;
> +		er_ctxt->ertype = cpu_to_le32(MHI_ER_TYPE_VALID);
> +		er_ctxt->msivec = cpu_to_le32(mhi_event->irq);
>  		mhi_event->db_cfg.db_mode = true;
>  
>  		ring->el_size = sizeof(struct mhi_tre);
> @@ -347,9 +347,9 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
>  		 * ring is empty
>  		 */
>  		ring->rp = ring->wp = ring->base;
> -		er_ctxt->rbase = ring->iommu_base;
> +		er_ctxt->rbase = cpu_to_le64(ring->iommu_base);
>  		er_ctxt->rp = er_ctxt->wp = er_ctxt->rbase;
> -		er_ctxt->rlen = ring->len;
> +		er_ctxt->rlen = cpu_to_le64(ring->len);
>  		ring->ctxt_wp = &er_ctxt->wp;
>  	}
>  
> @@ -376,9 +376,9 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
>  			goto error_alloc_cmd;
>  
>  		ring->rp = ring->wp = ring->base;
> -		cmd_ctxt->rbase = ring->iommu_base;
> +		cmd_ctxt->rbase = cpu_to_le64(ring->iommu_base);
>  		cmd_ctxt->rp = cmd_ctxt->wp = cmd_ctxt->rbase;
> -		cmd_ctxt->rlen = ring->len;
> +		cmd_ctxt->rlen = cpu_to_le64(ring->len);
>  		ring->ctxt_wp = &cmd_ctxt->wp;
>  	}
>  
> @@ -579,10 +579,10 @@ void mhi_deinit_chan_ctxt(struct mhi_controller *mhi_cntrl,
>  	chan_ctxt->rp = 0;
>  	chan_ctxt->wp = 0;
>  
> -	tmp = chan_ctxt->chcfg;
> +	tmp = le32_to_cpu(chan_ctxt->chcfg);
>  	tmp &= ~CHAN_CTX_CHSTATE_MASK;
>  	tmp |= (MHI_CH_STATE_DISABLED << CHAN_CTX_CHSTATE_SHIFT);
> -	chan_ctxt->chcfg = tmp;
> +	chan_ctxt->chcfg = cpu_to_le32(tmp);
>  
>  	/* Update to all cores */
>  	smp_wmb();
> @@ -616,14 +616,14 @@ int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
>  		return -ENOMEM;
>  	}
>  
> -	tmp = chan_ctxt->chcfg;
> +	tmp = le32_to_cpu(chan_ctxt->chcfg);
>  	tmp &= ~CHAN_CTX_CHSTATE_MASK;
>  	tmp |= (MHI_CH_STATE_ENABLED << CHAN_CTX_CHSTATE_SHIFT);
> -	chan_ctxt->chcfg = tmp;
> +	chan_ctxt->chcfg = cpu_to_le32(tmp);
>  
> -	chan_ctxt->rbase = tre_ring->iommu_base;
> +	chan_ctxt->rbase = cpu_to_le64(tre_ring->iommu_base);
>  	chan_ctxt->rp = chan_ctxt->wp = chan_ctxt->rbase;
> -	chan_ctxt->rlen = tre_ring->len;
> +	chan_ctxt->rlen = cpu_to_le64(tre_ring->len);
>  	tre_ring->ctxt_wp = &chan_ctxt->wp;
>  
>  	tre_ring->rp = tre_ring->wp = tre_ring->base;
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index 672052fe3b44..44634153ed04 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -209,14 +209,14 @@ extern struct bus_type mhi_bus_type;
>  #define EV_CTX_INTMODT_MASK GENMASK(31, 16)
>  #define EV_CTX_INTMODT_SHIFT 16
>  struct mhi_event_ctxt {
> -	__u32 intmod;
> -	__u32 ertype;
> -	__u32 msivec;
> -
> -	__u64 rbase __packed __aligned(4);
> -	__u64 rlen __packed __aligned(4);
> -	__u64 rp __packed __aligned(4);
> -	__u64 wp __packed __aligned(4);
> +	__le32 intmod;
> +	__le32 ertype;
> +	__le32 msivec;
> +
> +	__le64 rbase __packed __aligned(4);
> +	__le64 rlen __packed __aligned(4);
> +	__le64 rp __packed __aligned(4);
> +	__le64 wp __packed __aligned(4);
>  };
>  
>  #define CHAN_CTX_CHSTATE_MASK GENMASK(7, 0)
> @@ -227,25 +227,25 @@ struct mhi_event_ctxt {
>  #define CHAN_CTX_POLLCFG_SHIFT 10
>  #define CHAN_CTX_RESERVED_MASK GENMASK(31, 16)
>  struct mhi_chan_ctxt {
> -	__u32 chcfg;
> -	__u32 chtype;
> -	__u32 erindex;
> -
> -	__u64 rbase __packed __aligned(4);
> -	__u64 rlen __packed __aligned(4);
> -	__u64 rp __packed __aligned(4);
> -	__u64 wp __packed __aligned(4);
> +	__le32 chcfg;
> +	__le32 chtype;
> +	__le32 erindex;
> +
> +	__le64 rbase __packed __aligned(4);
> +	__le64 rlen __packed __aligned(4);
> +	__le64 rp __packed __aligned(4);
> +	__le64 wp __packed __aligned(4);
>  };
>  
>  struct mhi_cmd_ctxt {
> -	__u32 reserved0;
> -	__u32 reserved1;
> -	__u32 reserved2;
> -
> -	__u64 rbase __packed __aligned(4);
> -	__u64 rlen __packed __aligned(4);
> -	__u64 rp __packed __aligned(4);
> -	__u64 wp __packed __aligned(4);
> +	__le32 reserved0;
> +	__le32 reserved1;
> +	__le32 reserved2;
> +
> +	__le64 rbase __packed __aligned(4);
> +	__le64 rlen __packed __aligned(4);
> +	__le64 rp __packed __aligned(4);
> +	__le64 wp __packed __aligned(4);
>  };
>  
>  struct mhi_ctxt {
> @@ -258,8 +258,8 @@ struct mhi_ctxt {
>  };
>  
>  struct mhi_tre {
> -	u64 ptr;
> -	u32 dword[2];
> +	__le64 ptr;
> +	__le32 dword[2];
>  };
>  
>  struct bhi_vec_entry {
> @@ -277,57 +277,58 @@ enum mhi_cmd_type {
>  /* No operation command */
>  #define MHI_TRE_CMD_NOOP_PTR (0)
>  #define MHI_TRE_CMD_NOOP_DWORD0 (0)
> -#define MHI_TRE_CMD_NOOP_DWORD1 (MHI_CMD_NOP << 16)
> +#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(MHI_CMD_NOP << 16))
>  
>  /* Channel reset command */
>  #define MHI_TRE_CMD_RESET_PTR (0)
>  #define MHI_TRE_CMD_RESET_DWORD0 (0)
> -#define MHI_TRE_CMD_RESET_DWORD1(chid) ((chid << 24) | \
> -					(MHI_CMD_RESET_CHAN << 16))
> +#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> +					(MHI_CMD_RESET_CHAN << 16)))
>  
>  /* Channel stop command */
>  #define MHI_TRE_CMD_STOP_PTR (0)
>  #define MHI_TRE_CMD_STOP_DWORD0 (0)
> -#define MHI_TRE_CMD_STOP_DWORD1(chid) ((chid << 24) | \
> -				       (MHI_CMD_STOP_CHAN << 16))
> +#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> +				       (MHI_CMD_STOP_CHAN << 16)))
>  
>  /* Channel start command */
>  #define MHI_TRE_CMD_START_PTR (0)
>  #define MHI_TRE_CMD_START_DWORD0 (0)
> -#define MHI_TRE_CMD_START_DWORD1(chid) ((chid << 24) | \
> -					(MHI_CMD_START_CHAN << 16))
> +#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> +					(MHI_CMD_START_CHAN << 16)))
>  
> -#define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
> -#define MHI_TRE_GET_CMD_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
> +#define MHI_TRE_GET_DWORD(tre, word) (le32_to_cpu((tre)->dword[(word)]))
> +#define MHI_TRE_GET_CMD_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> +#define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
>  
>  /* Event descriptor macros */
> -#define MHI_TRE_EV_PTR(ptr) (ptr)
> -#define MHI_TRE_EV_DWORD0(code, len) ((code << 24) | len)
> -#define MHI_TRE_EV_DWORD1(chid, type) ((chid << 24) | (type << 16))
> -#define MHI_TRE_GET_EV_PTR(tre) ((tre)->ptr)
> -#define MHI_TRE_GET_EV_CODE(tre) (((tre)->dword[0] >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_LEN(tre) ((tre)->dword[0] & 0xFFFF)
> -#define MHI_TRE_GET_EV_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
> -#define MHI_TRE_GET_EV_STATE(tre) (((tre)->dword[0] >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_EXECENV(tre) (((tre)->dword[0] >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_SEQ(tre) ((tre)->dword[0])
> -#define MHI_TRE_GET_EV_TIME(tre) ((tre)->ptr)
> -#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits((tre)->ptr)
> -#define MHI_TRE_GET_EV_VEID(tre) (((tre)->dword[0] >> 16) & 0xFF)
> -#define MHI_TRE_GET_EV_LINKSPEED(tre) (((tre)->dword[1] >> 24) & 0xFF)
> -#define MHI_TRE_GET_EV_LINKWIDTH(tre) ((tre)->dword[0] & 0xFF)
> +#define MHI_TRE_EV_PTR(ptr) (cpu_to_le64(ptr))
> +#define MHI_TRE_EV_DWORD0(code, len) (cpu_to_le32((code << 24) | len))
> +#define MHI_TRE_EV_DWORD1(chid, type) (cpu_to_le32((chid << 24) | (type << 16)))
> +#define MHI_TRE_GET_EV_PTR(tre) (le64_to_cpu((tre)->ptr))
> +#define MHI_TRE_GET_EV_CODE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_LEN(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFFFF)
> +#define MHI_TRE_GET_EV_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
> +#define MHI_TRE_GET_EV_STATE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_EXECENV(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_SEQ(tre) MHI_TRE_GET_DWORD(tre, 0)
> +#define MHI_TRE_GET_EV_TIME(tre) (MHI_TRE_GET_EV_PTR(tre))
> +#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits(MHI_TRE_GET_EV_PTR(tre))
> +#define MHI_TRE_GET_EV_VEID(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 16) & 0xFF)
> +#define MHI_TRE_GET_EV_LINKSPEED(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> +#define MHI_TRE_GET_EV_LINKWIDTH(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFF)
>  
>  /* Transfer descriptor macros */
> -#define MHI_TRE_DATA_PTR(ptr) (ptr)
> -#define MHI_TRE_DATA_DWORD0(len) (len & MHI_MAX_MTU)
> -#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
> -	| (ieot << 9) | (ieob << 8) | chain)
> +#define MHI_TRE_DATA_PTR(ptr) (cpu_to_le64(ptr))
> +#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(len & MHI_MAX_MTU))
> +#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32((2 << 16) | (bei << 10) \
> +	| (ieot << 9) | (ieob << 8) | chain))
>  
>  /* RSC transfer descriptor macros */
> -#define MHI_RSCTRE_DATA_PTR(ptr, len) (((u64)len << 48) | ptr)
> -#define MHI_RSCTRE_DATA_DWORD0(cookie) (cookie)
> -#define MHI_RSCTRE_DATA_DWORD1 (MHI_PKT_TYPE_COALESCING << 16)
> +#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(((u64)len << 48) | ptr))
> +#define MHI_RSCTRE_DATA_DWORD0(cookie) (cpu_to_le32(cookie))
> +#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(MHI_PKT_TYPE_COALESCING << 16))
>  
>  enum mhi_pkt_type {
>  	MHI_PKT_TYPE_INVALID = 0x0,
> @@ -480,10 +481,10 @@ struct db_cfg {
>  	bool db_mode;
>  	u32 pollcfg;
>  	enum mhi_db_brst_mode brstmode;
> -	dma_addr_t db_val;
> +	__le64 db_val;
>  	void (*process_db)(struct mhi_controller *mhi_cntrl,
>  			   struct db_cfg *db_cfg, void __iomem *io_addr,
> -			   dma_addr_t db_val);
> +			   __le64 db_val);
>  };
>  
>  struct mhi_pm_transitions {
> @@ -499,7 +500,7 @@ struct state_transition {
>  struct mhi_ring {
>  	dma_addr_t dma_handle;
>  	dma_addr_t iommu_base;
> -	u64 *ctxt_wp; /* point to ctxt wp */
> +	__le64 *ctxt_wp; /* point to ctxt wp */
>  	void *pre_aligned;
>  	void *base;
>  	void *rp;
> @@ -649,10 +650,10 @@ static inline void mhi_trigger_resume(struct mhi_controller *mhi_cntrl)
>  
>  /* Register access methods */
>  void mhi_db_brstmode(struct mhi_controller *mhi_cntrl, struct db_cfg *db_cfg,
> -		     void __iomem *db_addr, dma_addr_t db_val);
> +		     void __iomem *db_addr, __le64 db_val);
>  void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
>  			     struct db_cfg *db_mode, void __iomem *db_addr,
> -			     dma_addr_t db_val);
> +			     __le64 db_val);
>  int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
>  			      void __iomem *base, u32 offset, u32 *out);
>  int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
> @@ -667,7 +668,7 @@ void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
>  			 u32 offset, u32 mask, u32 shift, u32 val);
>  void mhi_ring_er_db(struct mhi_event *mhi_event);
>  void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
> -		  dma_addr_t db_val);
> +		  __le64 db_val);
>  void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd);
>  void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
>  		      struct mhi_chan *mhi_chan);
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 8ac73f9e92a6..a8c68220d764 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -82,16 +82,18 @@ void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
>  }
>  
>  void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
> -		  dma_addr_t db_val)
> +		  __le64 db_val)
>  {
> -	mhi_write_reg(mhi_cntrl, db_addr, 4, upper_32_bits(db_val));
> -	mhi_write_reg(mhi_cntrl, db_addr, 0, lower_32_bits(db_val));
> +	dma_addr_t tmp = le64_to_cpu(db_val);
> +
> +	mhi_write_reg(mhi_cntrl, db_addr, 4, upper_32_bits(tmp));
> +	mhi_write_reg(mhi_cntrl, db_addr, 0, lower_32_bits(tmp));
>  }
>  
>  void mhi_db_brstmode(struct mhi_controller *mhi_cntrl,
>  		     struct db_cfg *db_cfg,
>  		     void __iomem *db_addr,
> -		     dma_addr_t db_val)
> +		     __le64 db_val)
>  {
>  	if (db_cfg->db_mode) {
>  		db_cfg->db_val = db_val;
> @@ -103,7 +105,7 @@ void mhi_db_brstmode(struct mhi_controller *mhi_cntrl,
>  void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
>  			     struct db_cfg *db_cfg,
>  			     void __iomem *db_addr,
> -			     dma_addr_t db_val)
> +			     __le64 db_val)
>  {
>  	db_cfg->db_val = db_val;
>  	mhi_write_db(mhi_cntrl, db_addr, db_val);
> @@ -119,10 +121,10 @@ void mhi_ring_er_db(struct mhi_event *mhi_event)
>  
>  void mhi_ring_cmd_db(struct mhi_controller *mhi_cntrl, struct mhi_cmd *mhi_cmd)
>  {
> -	dma_addr_t db;
> +	__le64 db;
>  	struct mhi_ring *ring = &mhi_cmd->ring;
>  
> -	db = ring->iommu_base + (ring->wp - ring->base);
> +	db = cpu_to_le64(ring->iommu_base + (ring->wp - ring->base));
>  	*ring->ctxt_wp = db;
>  	mhi_write_db(mhi_cntrl, ring->db_addr, db);
>  }
> @@ -131,9 +133,9 @@ void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
>  		      struct mhi_chan *mhi_chan)
>  {
>  	struct mhi_ring *ring = &mhi_chan->tre_ring;
> -	dma_addr_t db;
> +	__le64 db;
>  
> -	db = ring->iommu_base + (ring->wp - ring->base);
> +	db = cpu_to_le64(ring->iommu_base + (ring->wp - ring->base));
>  
>  	/*
>  	 * Writes to the new ring element must be visible to the hardware
> @@ -432,7 +434,7 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
>  	struct mhi_event_ctxt *er_ctxt =
>  		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
>  	struct mhi_ring *ev_ring = &mhi_event->ring;
> -	dma_addr_t ptr = er_ctxt->rp;
> +	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
>  	void *dev_rp;
>  
>  	if (!is_valid_ring_ptr(ev_ring, ptr)) {
> @@ -537,14 +539,14 @@ static void mhi_recycle_ev_ring_element(struct mhi_controller *mhi_cntrl,
>  
>  	/* Update the WP */
>  	ring->wp += ring->el_size;
> -	ctxt_wp = *ring->ctxt_wp + ring->el_size;
> +	ctxt_wp = le64_to_cpu(*ring->ctxt_wp) + ring->el_size;
>  
>  	if (ring->wp >= (ring->base + ring->len)) {
>  		ring->wp = ring->base;
>  		ctxt_wp = ring->iommu_base;
>  	}
>  
> -	*ring->ctxt_wp = ctxt_wp;
> +	*ring->ctxt_wp = cpu_to_le64(ctxt_wp);
>  
>  	/* Update the RP */
>  	ring->rp += ring->el_size;
> @@ -799,7 +801,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	u32 chan;
>  	int count = 0;
> -	dma_addr_t ptr = er_ctxt->rp;
> +	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
>  
>  	/*
>  	 * This is a quick check to avoid unnecessary event processing
> @@ -938,7 +940,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
>  		local_rp = ev_ring->rp;
>  
> -		ptr = er_ctxt->rp;
> +		ptr = le64_to_cpu(er_ctxt->rp);
>  		if (!is_valid_ring_ptr(ev_ring, ptr)) {
>  			dev_err(&mhi_cntrl->mhi_dev->dev,
>  				"Event ring rp points outside of the event ring\n");
> @@ -968,7 +970,7 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  	int count = 0;
>  	u32 chan;
>  	struct mhi_chan *mhi_chan;
> -	dma_addr_t ptr = er_ctxt->rp;
> +	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
>  
>  	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
>  		return -EIO;
> @@ -1009,7 +1011,7 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
>  		local_rp = ev_ring->rp;
>  
> -		ptr = er_ctxt->rp;
> +		ptr = le64_to_cpu(er_ctxt->rp);
>  		if (!is_valid_ring_ptr(ev_ring, ptr)) {
>  			dev_err(&mhi_cntrl->mhi_dev->dev,
>  				"Event ring rp points outside of the event ring\n");
> @@ -1531,7 +1533,7 @@ static void mhi_mark_stale_events(struct mhi_controller *mhi_cntrl,
>  	/* mark all stale events related to channel as STALE event */
>  	spin_lock_irqsave(&mhi_event->lock, flags);
>  
> -	ptr = er_ctxt->rp;
> +	ptr = le64_to_cpu(er_ctxt->rp);
>  	if (!is_valid_ring_ptr(ev_ring, ptr)) {
>  		dev_err(&mhi_cntrl->mhi_dev->dev,
>  			"Event ring rp points outside of the event ring\n");
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index bbf6cd04861e..0faf173fb963 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -218,7 +218,7 @@ int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl)
>  			continue;
>  
>  		ring->wp = ring->base + ring->len - ring->el_size;
> -		*ring->ctxt_wp = ring->iommu_base + ring->len - ring->el_size;
> +		*ring->ctxt_wp = cpu_to_le64(ring->iommu_base + ring->len - ring->el_size);
>  		/* Update all cores */
>  		smp_wmb();
>  
> @@ -420,7 +420,7 @@ static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
>  			continue;
>  
>  		ring->wp = ring->base + ring->len - ring->el_size;
> -		*ring->ctxt_wp = ring->iommu_base + ring->len - ring->el_size;
> +		*ring->ctxt_wp = cpu_to_le64(ring->iommu_base + ring->len - ring->el_size);
>  		/* Update to all cores */
>  		smp_wmb();
>  
> @@ -986,7 +986,7 @@ static void mhi_assert_dev_wake(struct mhi_controller *mhi_cntrl, bool force)
>  		atomic_inc(&mhi_cntrl->dev_wake);
>  		if (MHI_WAKE_DB_FORCE_SET_VALID(mhi_cntrl->pm_state) &&
>  		    !mhi_cntrl->wake_set) {
> -			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
> +			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, cpu_to_le64(1));
>  			mhi_cntrl->wake_set = true;
>  		}
>  		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
> @@ -1002,7 +1002,7 @@ static void mhi_assert_dev_wake(struct mhi_controller *mhi_cntrl, bool force)
>  		if ((atomic_inc_return(&mhi_cntrl->dev_wake) == 1) &&
>  		    MHI_WAKE_DB_SET_VALID(mhi_cntrl->pm_state) &&
>  		    !mhi_cntrl->wake_set) {
> -			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, 1);
> +			mhi_write_db(mhi_cntrl, mhi_cntrl->wake_db, cpu_to_le64(1));
>  			mhi_cntrl->wake_set = true;
>  		}
>  		spin_unlock_irqrestore(&mhi_cntrl->wlock, flags);
> -- 
> 2.32.0
> 
